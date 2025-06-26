#!/bin/bash

if [ -f ~/.ssh/agent.env ] ; then
    . ~/.ssh/agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        echo "Stale agent file found, missing pid. Spawning new agent… "
        eval `ssh-agent -t 24h | tee ~/.ssh/agent.env`
    fi
    if [ ! -S "$SSH_AUTH_SOCK" ] ; then
        echo "Stale agent file found, missing sock. Spawning new agent… "
        eval `ssh-agent -t 24h | tee ~/.ssh/agent.env`
    fi
else
    echo "Starting ssh-agent"
    eval `ssh-agent -t 24h | tee ~/.ssh/agent.env`
fi
