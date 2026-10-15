#!/usr/bin/env python3
"""Persist Finder list view the way the View Options checkboxes do.

"Always open in list view" and "Browse in list view" are stored in the parent
folder's .DS_Store. The home folder's parent is /Users, which is not writable,
so setting those checkboxes on the home folder lasts only until Finder quits.
"""

import os
import subprocess
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from ds_store import DSStore, DSStoreEntry  # noqa: E402

LIST_VIEW = b"Nlsv"
SKIP_CHILDREN = {"Desktop"}


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


def with_list_view(entries, names):
    names = set(names)
    kept = [
        entry
        for entry in entries
        if not (entry.filename in names and entry.code in (b"vstl", b"bRsV"))
    ]
    for name in sorted(names):
        kept.append(DSStoreEntry(name, b"bRsV", b"bool", True))
        kept.append(DSStoreEntry(name, b"vstl", b"type", LIST_VIEW))
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


def main():
    home = Path.home()
    home_name = home.name

    children = [
        name
        for name in os.listdir(home)
        if name not in SKIP_CHILDREN
        and not name.startswith(".")
        and (home / name).is_dir()
    ]
    home_store = home / ".DS_Store"
    save_entries(str(home_store), with_list_view(load_entries(str(home_store)), children))

    users_store = "/Users/.DS_Store"
    readable = users_store
    if os.path.exists(users_store) and not os.access(users_store, os.R_OK):
        fd, readable = tempfile.mkstemp(prefix="Users.DS_Store.read.")
        os.close(fd)
        subprocess.run(["sudo", "-n", "cp", users_store, readable], check=True)
    try:
        users_entries = with_list_view(load_entries(readable), [home_name])
    finally:
        if readable != users_store and os.path.exists(readable):
            os.unlink(readable)
    try:
        install_users_store(users_entries)
    except PermissionError:
        print(
            "Could not update /Users/.DS_Store (sudo required). "
            "List view is set on the folders inside your home folder; "
            "re-run macos/defaults.sh so the home folder itself keeps it.",
            file=sys.stderr,
        )
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
