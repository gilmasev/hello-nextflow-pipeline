#!/bin/bash -ue
cat 'Hola-output.txt' | tr '[a-z]' '[A-Z]' > 'UPPER-Hola-output.txt' //tr = UNIX text replacement; this code converts all file contents to UPPER case
