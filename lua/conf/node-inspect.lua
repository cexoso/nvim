local map = require('keymap').map;

map { "n", "®", ":NodeInspectStart<cr>"} -- <M-r> h for run
map { "n", "∫", ":NodeInspectToggleBreakpoint<cr>"} -- <M-b> for break
map { "n", "˙", ":NodeInspectRun<cr>"} -- <M-h> h for break
map { "n", "∆", ":NodeInspectStepOver<cr>"} -- <M-j> for next step
map { "n", "ß", ":NodeInspectStop<cr>"} -- <M-s> for next step
map { "n", "˚", ":NodeInspectStepInto<cr>"} -- <M-k> for step into
map { "n", "¬", ":NodeInspectStepOut<cr>"} -- <M-l> for step out

