#!/usr/bin/env python3.7

import iterm2
import sys

async def main(connection):
  app = await iterm2.async_get_app(connection)
  window = app.current_terminal_window

  if window is not None:
    user_chosen_font = sys.argv[1]

    session = window.current_tab.current_session
    profile = await session.async_get_profile()
    await profile.async_set_normal_font(user_chosen_font)

iterm2.run_until_complete(main)
