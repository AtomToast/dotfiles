#!/bin/env python

import re
from xkeysnail.transform import *

# multipurpose mappings
define_multipurpose_modmap(
    # casplock acts as Escape when pressed and released
    # and as Control when held down with another key
    {Key.CAPSLOCK: [Key.ESC, Key.LEFT_CTRL]},
)

# use AltGr + hjkl as arrow keys
define_keymap(lambda wm_class: wm_class not in ("brawlhalla.exe", "Dwarf_Fortress"), {
    # AltGr + hjkl acts as arrow keys
    K("RM-h"): K("left"),
    K("RM-j"): K("down"),
    K("RM-k"): K("up"),
    K("RM-l"): K("right"),
    # alt works as expected
    K("LM-RM-h"): K("LM-left"),
    K("LM-RM-j"): K("LM-down"),
    K("LM-RM-k"): K("LM-up"),
    K("LM-RM-l"): K("LM-right"),
    # ctrl works as expected
    K("C-RM-h"): K("C-left"),
    K("C-RM-j"): K("C-down"),
    K("C-RM-k"): K("C-up"),
    K("C-RM-l"): K("C-right"),
    # shift works as expecteed
    K("Shift-RM-h"): K("Shift-left"),
    K("Shift-RM-j"): K("Shift-down"),
    K("Shift-RM-k"): K("Shift-up"),
    K("Shift-RM-l"): K("Shift-right"),

    # ctrl + shift works as expecteed
    K("C-Shift-RM-h"): K("C-Shift-left"),
    K("C-Shift-RM-j"): K("C-Shift-down"),
    K("C-Shift-RM-k"): K("C-Shift-up"),
    K("C-Shift-RM-l"): K("C-Shift-right"),
    # alt + shift works as expecteed
    K("LM-Shift-RM-h"): K("LM-Shift-left"), K("LM-Shift-RM-j"): K("LM-Shift-down"), K("LM-Shift-RM-k"): K("LM-Shift-up"),
    K("LM-Shift-RM-l"): K("LM-Shift-right"),
    K("Shift-RM-h"): K("Shift-left"),
    # ctrl + alt works as expected
    K("C-LM-RM-h"): K("C-LM-left"),
    K("C-LM-RM-j"): K("C-LM-down"),
    K("C-LM-RM-k"): K("C-LM-up"),
    K("C-LM-RM-l"): K("C-LM-right"),

    # ctrl + shift + alt works as expected
    K("C-Shift-LM-RM-h"): K("C-Shift-LM-left"),
    K("C-Shift-LM-RM-j"): K("C-Shift-LM-down"),
    K("C-Shift-LM-RM-k"): K("C-Shift-LM-up"),
    K("C-Shift-LM-RM-l"): K("C-Shift-LM-right"),

    # disable arrow keys for now
    K("left"):  K("UNKNOWN"),
    K("down"):  K("UNKNOWN"),
    K("up"):    K("UNKNOWN"),
    K("right"): K("UNKNOWN"),

    # disable page up and down keys
    K("page_down"): K("UNKNOWN"),
    K("page_up"):   K("UNKNOWN"),

    # disable enter
    K("enter"): K("UNKNOWN"),
    K("RM-enter"): K("enter"),

    # disable backspace
    K("backspace"): K("UNKNOWN"),
    K("RM-backspace"): K("backspace"),

}, "hjkl arrow keys")

# Keybindings for Firefox
define_keymap(re.compile("firefox"), {
    # use ctrl+n to tab
    K("C-n"): K("TAB"),
    # ctrl+shift+w acts as the normal ctrl+w to close a tab
    K("C-Shift-w"): K("C-w"),
    # disable ctrl+q
    K("C-q"): K("UNKNOWN"),
}, "Firefox")

# Keybindings for Discord
define_keymap(re.compile("discord|TelegramDesktop|Slack|Signal|Riot|Jitsi Meet"), {
    # use ctrl+u/d to page up/down
    K("C-u"): K("page_up"),
    K("C-d"): K("page_down"),
    K("RM-g"): K("Shift-page_up"),
    K("Shift-RM-g"): K("Shift-page_down"),
}, "Discord, Slack, Signal, Riot, Jitsi Meet and Telegram")

define_keymap(lambda wm_class: wm_class not in ("st-256color", "Alacritty", "Termite"), {
    # ctrl+w deletes a word
    K("C-w"): K("C-backspace"),
    # ctrl+m works as enter
    K("C-m"): K("enter"),
    # ctrl+j works as newline
    K("C-j"): K("Shift-enter"),
    # ctrl+h works as backspace
    K("C-h"): K("backspace"),
    # AltGr+g/G jump to start/end of messages
}, "Enable readline outside of applications that already have them")
