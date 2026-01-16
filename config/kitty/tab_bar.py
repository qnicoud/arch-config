#!/usr/bin/python

import datetime
from kitty.fast_data_types import Screen, get_boss
from kitty.tab_bar import (DrawData, ExtraData, TabBarData,
    as_rgb, draw_tab_with_powerline, powerline_symbols, draw_title)
from kitty.utils import color_as_int

def get_active_tab_index() -> int:
    return get_boss().active_tab_manager.active_tab_idx + 1

def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    active_bg = screen.cursor.bg
    active_fg = screen.cursor.fg
    default_bg = as_rgb(int(draw_data.default_bg))

    if extra_data.next_tab:
        next_tab_bg = as_rgb(draw_data.tab_bg(extra_data.next_tab))
    else:
        next_tab_bg = default_bg
    if extra_data.prev_tab:
        prev_tab_bg = as_rgb(draw_data.tab_bg(extra_data.prev_tab))
    else:
        prev_tab_bg = default_bg

    if index == get_active_tab_index():
        screen.cursor.fg=active_bg
        screen.cursor.bg=prev_tab_bg
        screen.draw('')
        screen.cursor.fg=active_fg
        screen.cursor.bg=active_bg
        screen.draw(' ')
        draw_title(draw_data, screen, tab, index, max_tab_length)
        # ----------
        extra = screen.cursor.x + 1 - before - max_tab_length
        if extra > 0 and extra + 1 < screen.cursor.x:
            screen.cursor.x -= extra
            screen.draw('…')
        # ----------
        screen.draw(' ')
        screen.cursor.fg=active_bg
        screen.cursor.bg=next_tab_bg
        screen.draw('')
    elif index < get_active_tab_index():
        if index == 1:
            screen.cursor.fg=active_bg
            screen.cursor.bg=default_bg
            screen.draw('')
            screen.cursor.fg=active_fg
            screen.cursor.bg=active_bg
        else:
            screen.cursor.fg=default_bg
            screen.draw('')
        screen.draw(' ')
        draw_title(draw_data, screen, tab, index, max_tab_length)
        # ----------
        extra = screen.cursor.x + 1 - before - max_tab_length
        # print(screen.cursor.x,before,max_tab_length,"->",extra)
        if extra > 0 and extra + 1 < screen.cursor.x:
            screen.cursor.x -= extra
            screen.draw('…')
        # ----------
        screen.draw(' ')
    elif index > get_active_tab_index():
        screen.draw(' ')
        draw_title(draw_data, screen, tab, index, max_tab_length)
        # ----------
        extra = screen.cursor.x + 2 - before - max_tab_length
        if extra > 0 and extra + 1 < screen.cursor.x:
            screen.cursor.x -= extra
            screen.draw('…')
        # ----------
        screen.draw(' ')
        if is_last:
            screen.cursor.fg=active_bg
            screen.cursor.bg=default_bg
            screen.draw('')
        else:
            screen.cursor.fg=default_bg
            screen.draw('')

    end = screen.cursor.x
    # if end < screen.columns:
    #     screen.draw(' ')
    return end
