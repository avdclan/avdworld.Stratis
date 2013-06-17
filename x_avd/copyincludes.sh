#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

DIRS=$(find . -type d |grep -v .git |grep -v include)
for i in $DIRS; do 
	cp -rp include $i/; 
done