#!/bin/bash

git config -l | grep "alias." | awk 'BEGIN { FS = "[=]" } { sub(/alias\./, "", $1); sub(/!/, "", $2); print "\033[01;32m" $1 "\033[01;00m = \033[01;34m" $2; }'
