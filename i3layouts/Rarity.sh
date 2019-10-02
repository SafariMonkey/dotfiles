#!/bin/bash
i3-msg "workspace 1; append_layout ~/.i3/workspace-1.json"
(chromium &)
(termite &)
(termite --exec=ncspot --title=Spotify &)
(termite --exec=ncspot --title=Bluetooth &)
(pavucontrol &)

