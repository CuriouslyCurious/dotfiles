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
import sys


# Globals
ignore = [".git"]

parser = argparse.ArgumentParser(
        description="A symlinking script for handling dotfiles, similar to stow.")
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

    if args.verbose:
        print_ln(origin, target)

    if not args.skip:
        confirm = None
        if not args.no and not args.yes:
            while confirm is None:
                try:
                    confirm = prompt(origin, target)
                except SyntaxError:
                    continue

        if not args.remove and (args.yes or confirm):
            if not target.is_symlink:
                origin.symlink_to(target, target.is_dir())

        if args.remove and (args.yes or confirm):
            if target.is_symlink():
                target.unlink()


def prompt(origin, target):
    if not args.remove:
        text = """Do you wish to symlink '%s' to '%s'?
{y(es) / n(o); YES (to all) / NO (to all)}: """ % (str(origin), str(target))
    else:
        text = """Do you wish to remove '%s'?
{y(es) / n(o); YES (to all) / NO (to all)}: """ % (str(target))

    inp = input(text)

    if inp.startswith("y"):
        return True
    elif inp.startswith("n"):
        return False
    elif inp == "YES":
        args.yes = True
        args.verbose = True
        return True
    elif inp == "NO":
        args.no = True
        args.verbose = True
        return False
    else:
        raise(SyntaxError)


def print_ln(origin, target):
    if not args.remove:
        print("ln -s %s %s" % (str(origin), str(target)))
    else:
        print("unlink %s" % str(target))


if __name__ == "__main__":
    home = pathlib.Path.home()
    dotfiles_dir = pathlib.Path(str(home) + "/dotfiles")

    if not dotfiles_dir.exists():
        sys.exit('%s is not a directory' % (str(home) + "/dotfiles"))

    for path in dotfiles_dir.iterdir():
        if path.is_dir():
            if str(path).split("/")[-1] in ignore:
                continue
            elif str(path).endswith("/etc"):
                symlink(path, pathlib.Path("/etc"))
            else:
                sub_path(path, home)

