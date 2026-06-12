#!/bin/bash -ue
cat COLLECTED-yaml-output.txt | cowpy -c "stegosaurus" > cowpy-COLLECTED-yaml-output.txt
