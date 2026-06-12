#!/bin/bash -ue
cat UPPER-Bonjour-output.txt UPPER-Hello-output.txt UPPER-Hola-output.txt > 'COLLECTED-with_report-output.txt'
echo 'There were 3 greetings in this batch.' > 'with_report-report.txt'
