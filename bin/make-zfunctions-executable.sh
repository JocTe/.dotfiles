#!/bin/bash

ZFUNCDIR="${ZDOTDIR:-$HOME}/.zfunctions"

if [ -d "$ZFUNCDIR" ]; then
    echo "Making ZSH functions executable..."
    chmod +x "$ZFUNCDIR"/*
    echo "Done!"
else
    echo "ZSH functions directory not found at $ZFUNCDIR"
fi
