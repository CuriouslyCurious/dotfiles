#!/usr/bin/env python3
# -*- coding: utf8 -*-

"""
An implementation of stow in Python

This program assumes that the dotfiles folder is located at
$HOME/dotfiles
"""

__author__ = "curious"

import argparse
import pathlib
import textwrap
import shutil

from sys import exit

# Globals
ignore = [".git"]

parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=textwrap.dedent("""\
                A symlinking script for handling dotfiles in a similar manner to stow.

                WARNING: This script may crush your dreams (and files) if you are
                not careful."""))
parser.add_argument("-s", "--skip", dest="skip", action="store_true", default=False,
                    help="skip any conflicts")
parser.add_argument("-N", "--NO", dest="no", action="store_true", default=False,
                    help="don't perform any symlinks, just print the results.")
parser.add_argument("-Y", "--YES", dest="yes", action="store_true", default=False,
                    help="say yes to all prompts")
parser.add_argument("-v", "--verbose", dest="verbose", action="store_true", default=False,
                    help="verbose mode")
parser.add_argument("-r", "--remove", dest="remove", action="store_true", default=False,
                    help="remove all symlinks")
parser.add_argument("-R", "--replace", dest="replace", action="store_true", default=False,
                    help="replace all existing files (no prompt)")
args = parser.parse_args()

if args.no or args.yes:
    args.verbose = True


def sub_path(path, target):
    for sub in path.iterdir():
        if str(sub).split("/")[-1] == ".config":
            for sub_sub in sub.iterdir():
                target = str(target) + "/.config"
                symlink(sub_sub, pathlib.Path(target))
        else:
            symlink(sub, target)


def symlink(origin, target):
    if len(str(target).split("/")) != 2:
        target = pathlib.Path(str(target) + "/" + str(origin).split("/")[-1])

    if args.no or args.verbose:
        print_ln(origin, target)
        return

    if not args.remove and (args.yes or prompt(origin, target)):
        if not target.is_symlink():
            if not target.is_file() and not target.is_dir():
                target.symlink_to(origin, origin.is_dir())
            else:
                if args.skip or args.no:
                    return

                if str(target) == "/etc":
                    print("Skipping... /etc will never be replaced by this script.")
                    return

                print("%s will be replaced!" % str(target))
                if args.replace or prompt(origin, target, "replace"):
                    if target.is_dir():
                        shutil.rmtree(target)
                    elif target.is_file():
                        target.unlink()

                    target.symlink_to(origin, origin.is_dir())

    elif args.remove and (args.yes or prompt(origin, target, "remove")):
        if str(target) == "/etc":
            print("Skipping... /etc will never be replaced by this script.")
            return

        if target.is_symlink():
            target.unlink()


def prompt(origin, target, action=None):
    if action == "remove":
        text = """Do you wish to remove '%s'?
{y(es) / n(o); YES (to all) / NO (to all)}: """ % (str(target))
    elif action == "replace":
        text = """Do you wish to replace '%s' with '%s'?
{y(es) / n(o); YES (to all) / NO (to all)}: """ % (str(origin), str(target))
    else:
        text = """Do you wish to symlink '%s' to '%s'?
{y(es) / n(o); YES (to all) / NO (to all)}: """ % (str(origin), str(target))

    if target.is_dir() and (action == "replace" or action == "remove"):
        text += "\nWARNING: This will delete all contents in the directory: "

    while True:
        inp = input(text)
        if len(inp) == 0:
            return True
        elif inp.startswith("y"):
            return True
        elif inp.startswith("n"):
            return False
        elif inp == "YES":
            args.yes = True
            args.verbose = True
            if action == "replace":
                args.replace = True
            return True
        elif inp == "NO":
            args.no = True
            args.verbose = True
            if action == "replace":
                args.skip = True
            return False


def print_ln(origin, target):
    if not args.remove:
        print("ln -s %s %s" % (str(origin), str(target)))
    else:
        print("unlink %s" % str(target))


if __name__ == "__main__":
    home = pathlib.Path.home()
    dotfiles_dir = pathlib.Path(str(home) + "/dotfiles")

    if not dotfiles_dir.exists():
        exit('%s is not a directory' % (str(home) + "/dotfiles"))

    for path in dotfiles_dir.iterdir():
        if path.is_dir():
            if str(path).split("/")[-1] in ignore:
                continue
            elif str(path).endswith("/etc"):
                symlink(path, pathlib.Path("/etc"))
            else:
                sub_path(path, home)

