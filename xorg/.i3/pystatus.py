#!/usr/bin/env python3

import multiprocessing
import subprocess

import i3pystatus
from i3pystatus.weather import weathercom


CPU_COUNT = multiprocessing.cpu_count()
COLORS = {
    'red': '#ef2929',
    'green': '#73d216',
    'blue': '#2e9ef4',
}


class Loas(i3pystatus.IntervalModule):
  """Periodically retrieves LOAS status."""

  interval = 10
  color = COLORS['green']
  warn_color = COLORS['red']

  def run(self):
    status = subprocess.call(['/usr/bin/prodcertstatus', '-q'])
    color = self.warn_color if status else self.color

    self.output = {
        'full_text': 'LOAS',
        'color': color,
    }


if __name__ == '__main__':
  status = i3pystatus.Status(standalone=True, click_events=False)
  status.register('clock', format=('%-d %b %H:%M %Z', 'America/Los_Angeles'))
  status.register('clock', format='%a %-d %b %H:%M', color=COLORS['blue'])
  status.register('load',
                  format='{avg1} {avg5} {avg15}',
                  critical_limit=CPU_COUNT)
  status.register(Loas)
  status.register('pulseaudio',
                  format='♪ {volume}',
                  format_muted='■ {volume}',
                  color_muted='#ffff00',
                  color_unmuted='#ff0000',
                  multi_colors=True)
  status.register('now_playing',
                  format="{artist} - {title} {status}",
                  hide_no_player=True)
  status.run()
