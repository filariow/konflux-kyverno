#!/bin/bash

grep 'branch =' '.gitmodules' | cut -d '=' -f 2 | tr -d ' '

