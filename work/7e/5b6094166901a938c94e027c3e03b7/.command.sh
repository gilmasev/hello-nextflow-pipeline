#!/bin/bash -ue
cat UPPER-Bonjour-output.txt UPPER-Hello-output.txt UPPER-Hola-output.txt > 'COLLECTED-my_run-output.txt'
echo 'There were 3 greetings in this batch.' > 'my_run-report.txt'
