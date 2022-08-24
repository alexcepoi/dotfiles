! fonts
Xft.dpi: 96
Xft.rgba: rgb
Xft.antialias: true
Xft.hinting: true
Xft.hintstyle: hintslight
Xft.lcdfilter: lcddefault
*TkTheme: clearlooks

! vt100
*vt100.utf8: true
*vt100.eightBitInput:   false
*vt100.eightBitControl: false
*vt100.eightBitOutput:  true

*vt100.foreground: #eeeeee
*vt100.background: #222222
*vt100.color0: #2e3436
*vt100.color1: #cc0000
*vt100.color2: #4e9a06
*vt100.color3: #c4a000
*vt100.color4: #3465a4
*vt100.color5: #75507b
*vt100.color6: #06989a
*vt100.color7: #d3d7cf
*vt100.color8: #555753
*vt100.color9: #ef2929
*vt100.color10: #8ae234
*vt100.color11: #fce94f
*vt100.color12: #729fcf
*vt100.color13: #ad7fa8
*vt100.color14: #34e2e2
*vt100.color15: #eeeeec

! xterm
xterm*faceName: Dejavu Sans Mono
xterm*faceSize: 9
xterm*termName: xterm-256color
xterm*saveLines: 100000

! urxvt
urxvt.foreground: #eeeeee
urxvt.background: #111111
urxvt.color0: #2e3436
urxvt.color1: #cc0000
urxvt.color2: #4e9a06
urxvt.color3: #c4a000
urxvt.color4: #3465a4
urxvt.color5: #75507b
urxvt.color6: #06989a
urxvt.color7: #d3d7cf
urxvt.color8: #555753
urxvt.color9: #ef2929
urxvt.color10: #8ae234
urxvt.color11: #fce94f
urxvt.color12: #729fcf
urxvt.color13: #ad7fa8
urxvt.color14: #34e2e2
urxvt.color15: #eeeeec

urxvt.font: xft:Dejavu Sans Mono:size=9
urxvt.letterSpace: -1
urxvt.cursorBlink: 1

urxvt.saveLines: 100000
urxvt.scrollBar: rxvt
urxvt.scrollTtyOutput: false
urxvt.scrollWithBuffer: true
urxvt.scrollTtyKeypress: true

urxvt.iso14755: false
urxvt.iso14755_52: false

! plugins
urxvt.perl-ext: default,url-select,52-osc
urxvt.url-select.launcher: ./.local/bin/i3-launch-in-sidebrowser
urxvt.url-select.underline: true
urxvt.keysym.M-u: perl:url-select:select_next
