#!/bin/bash -ue
cat UPPER-Hello-output.txt UPPER-Hola-output.txt UPPER-Bonjour-output.txt > 'COLLECTED-conda-output.txt'
echo 'There were 3 greetings in this batch.' > 'conda-report.txt'
