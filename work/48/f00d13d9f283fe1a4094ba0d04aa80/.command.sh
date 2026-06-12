#!/bin/bash -ue
cat 'Hello-output.txt' | tr '[a-z]' '[A-Z]' > 'UPPER-Hello-output.txt' //tr = UNIX text replacement; this code converts all file contents to UPPER case
