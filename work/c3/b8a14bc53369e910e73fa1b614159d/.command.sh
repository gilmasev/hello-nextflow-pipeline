#!/bin/bash -ue
cat 'Bonjour-output.txt' | tr '[a-z]' '[A-Z]' > 'UPPER-Bonjour-output.txt' //tr = UNIX text replacement; this code converts all file contents to UPPER case
