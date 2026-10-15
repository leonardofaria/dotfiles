#!/usr/bin/env python3
"""Make Finder sidebar folders open in list view.

Each folder keeps its own view in a .DS_Store record named vstl. Applications
is saved as icnv ("always open in icon view"). Clicking it switches the
window to icons, and every other sidebar item that does not have its own list
view then follows. Recents is not a folder; its view is a Finder preference,
not one of these records.

Finder drops a bare vstl record the next time it saves the file. A folder it
has actually shown in list view also has lsvp, lsvC, and vSrn, and those
survive. Copy that set from a folder Finder already saved.
"""

import os
import subprocess
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from ds_store import DSStore, DSStoreEntry  # noqa: E402

LIST_VIEW = b"Nlsv"
LIST_VIEW_CODES = (b"vstl", b"lsvp", b"lsvC", b"vSrn")
# Desktop icons are a separate view from the Desktop folder window. Leave
# that folder's saved view alone.
SIDEBAR_FOLDERS = (
    "Documents",
    "Downloads",
    "Pictures",
    "Music",
    "Movies",
    "Public",
)


def load_entries(path):
    if not os.path.exists(path):
        return []
    try:
        with DSStore.open(path, "r") as store:
            return list(store)
    except (OSError, ValueError, KeyError):
        return []


def save_entries(path, entries):
    directory = os.path.dirname(path) or "."
    fd, tmp = tempfile.mkstemp(prefix=".DS_Store.", dir=directory)
    os.close(fd)
    try:
        with DSStore.open(tmp, "w+", initial_entries=entries):
            pass
        os.replace(tmp, path)
    except Exception:
        os.unlink(tmp)
        raise


def records_by_name(entries):
    grouped = {}
    for entry in entries:
        grouped.setdefault(entry.filename, {})[entry.code] = entry
    return grouped


def list_view_template(entries):
    for records in records_by_name(entries).values():
        view = records.get(b"vstl")
        if view is not None and view.value == LIST_VIEW and b"lsvp" in records:
            return records
    return {}


def with_list_view(entries, names, template):
    names = set(names)
    kept = [
        entry
        for entry in entries
        if not (entry.filename in names and entry.code in LIST_VIEW_CODES)
    ]
    for name in sorted(names):
        kept.append(DSStoreEntry(name, b"vstl", b"type", LIST_VIEW))
        kept.append(DSStoreEntry(name, b"vSrn", b"long", 1))
        for code in (b"lsvp", b"lsvC"):
            source = template.get(code)
            if source is not None:
                kept.append(DSStoreEntry(name, code, source.type, source.value))
    return kept


def run_as_root(script):
    result = subprocess.run(["sudo", "-n", "sh", "-c", script], check=False)
    if result.returncode != 0:
        raise PermissionError("sudo is required to update /Users/.DS_Store")


def install_users_store(entries):
    fd, tmp = tempfile.mkstemp(prefix="Users.DS_Store.")
    os.close(fd)
    try:
        with DSStore.open(tmp, "w+", initial_entries=entries):
            pass
        run_as_root(
            f'cp "{tmp}" /Users/.DS_Store && '
            "chown root:wheel /Users/.DS_Store && "
            "chmod 644 /Users/.DS_Store"
        )
    finally:
        os.unlink(tmp)


def update_store(path, names, template):
    entries = load_entries(path)
    if not template:
        template = list_view_template(entries)
    save_entries(path, with_list_view(entries, names, template))


def main():
    home = Path.home()
    home_store = home / ".DS_Store"
    template = list_view_template(load_entries(str(home_store)))

    update_store(str(home_store), SIDEBAR_FOLDERS, template)
    applications = Path("/Applications/.DS_Store")
    if applications.exists():
        update_store(str(applications), ["."], template)

    users_store = "/Users/.DS_Store"
    readable = users_store
    if os.path.exists(users_store) and not os.access(users_store, os.R_OK):
        fd, readable = tempfile.mkstemp(prefix="Users.DS_Store.read.")
        os.close(fd)
        subprocess.run(["sudo", "-n", "cp", users_store, readable], check=True)
    try:
        users_entries = with_list_view(load_entries(readable), [home.name], template)
    finally:
        if readable != users_store and os.path.exists(readable):
            os.unlink(readable)
    try:
        install_users_store(users_entries)
    except PermissionError:
        print(
            "Could not update /Users/.DS_Store (sudo required). "
            "Sidebar folders were updated; re-run macos/defaults.sh so the "
            "home folder itself keeps list view.",
            file=sys.stderr,
        )
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
