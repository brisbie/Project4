#!/bin/bash
#========================================================
# B+ TREE AUTOMATED TEST SCRIPT
#========================================================

# TEST 1: Build B+ Tree
%echo "TEST 1: Build B+ Tree"
./project4 --build

# TEST 2: Search Valid ZIP Codes
%echo "TEST 2: Search Valid ZIP Codes 10001, 90210, 60601"
./project4 -search 10001
./project4 -search 90210
./project4 -search 60601

# TEST 3: Search Invalid ZIP Code
%echo "TEST 3: Search Invalid ZIP Code 00000"
./project4 -search 00000

# TEST 4: Sequence Set Scan by State
%echo "TEST 4: Sequence Set Scan by State VI"
./project4 -state VI

# TEST 5: Dump Tree
%echo "TEST 5: Dump Tree"
./project4 --dump

#========================================================
# End of Test Script
#========================================================
