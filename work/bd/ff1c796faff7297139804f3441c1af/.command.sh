#!/bin/bash -ue
cat UPPER-Hello-output.txt UPPER-Bonjour-output.txt UPPER-Hola-output.txt > 'counted-trio-output.txt'
echo 'There were 3 greetings in this batch.' > 'trio-report.txt'
