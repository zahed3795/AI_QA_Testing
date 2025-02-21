"""
Automation console scripts runner

Usage:
Automation [COMMAND] [PARAMETERS]

Examples:
Automation
"""

import argparse
import sys
from contextlib import suppress
import colorama
import sys
import time


def show_basic_usage():
    sc = ""
    sc += "╭──────────────────────────────────────────────────╮\n"
    sc += '│  * Options: "automation [Options]           "    │\n'
    sc += "│  --Help          Show this message and exit.     │\n"
    sc += "│  --Version       Show version if the framework.  │\n"
    sc += '│  *  EXAMPLE => "automation"                      │\n'
    sc += "╰──────────────────────────────────────────────────╯\n"
    sc += "\n"
    sc += "╭──────────────────────────────────────────────────╮\n"
    sc += '│  * Command: "automation [COMMAND] [PARAMETERS]"  │\n'
    sc += "│                                                  │\n"
    sc += "│ COMMANDS:        PARAMETERS / DESCRIPTIONS:      │\n"
    sc += "│    automation                                    │\n"
    sc += "│                                                  │\n"
    sc += '│ *  EXAMPLE => "automation"                       │\n'
    sc += "╰──────────────────────────────────────────────────╯"
    sc += ""
    bordered_sc = sc

    with suppress(Exception):
        print(sc)
        return
    sc = bordered_sc.replace("╮\n", "")
    sc = sc.replace("╭", "").replace("╮", "").replace("│", "")
    sc = sc.replace("╰", "").replace("╯", "").replace("─", "")
    print(sc)


def install_chromedriver():
    pass


def main_cli():
    num_args = len(sys.argv)
    if sys.argv[0].split('/')[-1].lower() == "automation" or (
            sys.argv[0].split('\\')[-1].lower() == "automation"):
        if num_args > 5:
            show_basic_usage()

    if num_args == 1:
        show_basic_usage()

    elif num_args == 2:
        command = sys.argv[1]
        if command == 'driver':
            install_chromedriver()


if __name__ == "__main__":
    main_cli()
