#!/usr/bin/env python3
# -*- coding: utf8 -*-

"""
A more advanced python calculator to be used from the command-line
"""

import code
import readline
import rlcompleter

from sympy import *


def digit_to_char(digit):
    if digit < 10:
        return str(digit)
    return chr(ord('a') + digit - 10)

def base(num, b=16):
    if num < 0:
        return '-' + base(-num, b)
    (d, m) = divmod(num, b)
    if d > 0:
        return base(d, b) + digit_to_char(m)
    return digit_to_char(m)

# Thanks to http://eosrei.net/articles/2015/12/using-python-3-screen-logging-command-line-calculator
vars = globals()
vars.update(locals())
readline.set_completer(rlcompleter.Completer(vars).complete)
readline.parse_and_bind("tab: complete")
shell = code.InteractiveConsole(vars)
shell.interact()


