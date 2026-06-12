#!/bin/bash -ue
cat UPPER-Hello-output.txt UPPER-Bonjour-output.txt UPPER-Hola-output.txt > 'COLLECTED-experiment-output.txt'
echo 'There were 3 greetings in this batch.' > 'experiment-report.txt'
