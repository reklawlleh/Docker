#!/bin/bash
tmux new -s modserver -d
tmux send-keys -t modserver "./start-tModLoaderServer.sh" Enter
tmux send-keys -t modserver "n" Enter
tmux attach -t modserver 