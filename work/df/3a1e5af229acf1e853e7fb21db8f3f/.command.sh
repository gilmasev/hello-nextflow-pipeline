#!/bin/bash -ue
cat UPPER-Hola-output.txt UPPER-Hello-output.txt UPPER-Bonjour-output.txt > 'COLLECTED-batch-output.txt'
echo 'There were 3 greetings in this batch.' > 'batch-report.txt'
