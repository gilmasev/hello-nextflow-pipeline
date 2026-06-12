#!/bin/bash -ue
cat UPPER-Bonjour-output.txt UPPER-Hola-output.txt UPPER-Hello-output.txt > 'COLLECTED-batch-output.txt'
echo 'There were 3 greetings in this batch.' > 'batch-report.txt'
