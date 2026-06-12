#!/bin/bash -ue
cat UPPER-Hello-output.txt UPPER-Hola-output.txt UPPER-Bonjour-output.txt > 'COLLECTED-yaml-output.txt'
echo 'There were 3 greetings in this batch.' > 'yaml-report.txt'
