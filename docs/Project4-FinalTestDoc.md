B+ TREE FINAL TEST DOCUMENT
===========================

- Project: CSCI 331 – Project 4
- Authors: Team 5


Test Environment:
-----------------
- OS: Unix / Windows
- Compiler: g++ (std=c++17)
- Project Directory: Project4/
- Input CSV: data/us_postal_codes.csv
- Output Binary: data/newBinaryPCodes.dat
- B+ Tree File: data/zipCodes.bss

Testing Goals:
--------------
The tests below are designed to verify the correctness, efficiency, and robustness of the B+ Tree class and its associated BSS file handling. Tests include static B+ Tree construction, index search, sequence set traversal, and edge cases.

Test Summary Table:
------------------
| Test # | Description                                    | Purpose / Rationale                                        | Expected Result                      | Actual Result        |
|--------|-----------------------------------------------|-----------------------------------------------------------|--------------------------------------|--------------------|
| 1      | Build B+ Tree                                  | Ensure tree can be built from CSV / BSS file             | data/zipCodes.bss created & populated | Success             |
| 2      | Search Valid ZIP Codes                         | Verify index lookup works for existing keys              | Correct record returned               | Success             |
| 3      | Search Invalid ZIP Code                        | Check tree gracefully handles missing keys               | "Not found" or empty result           | Success             |
| 4      | Sequence Set Scan by State                     | Verify sequential leaf traversal                         | All records in state printed          | Success             |
| 5      | Dump Tree                                      | Debugging / visualize tree structure                     | Tree structure printed to console     | Success             |

Detailed Test Descriptions:
---------------------------

TEST 1: BUILD B+ TREE
- Purpose: Verify the static B+ Tree can be built from CSV data. Ensures proper creation of leaf blocks and index layers.
- Procedure:
    1. Ensure binary data exists using `ensureBinaryDataExists()`.
    2. Call `BPlusTree::build("data/zipCodes.bss", "data/newBinaryPCodes.dat")`.
    3. Check that BSS file exists and contains non-empty blocks.
- Result: File created successfully, B+ Tree constructed. Root RBN set correctly.

TEST 2: SEARCH VALID ZIP CODES
- Purpose: Validate that index search retrieves correct record for valid ZIP codes.
- Procedure:
    1. Call `BPlusTree::search("10001")`.
    2. Call `BPlusTree::search("90210")`.
    3. Call `BPlusTree::search("60601")`.
- Result: All three ZIP codes returned with correct city/state info. Test passed.

TEST 3: SEARCH INVALID ZIP CODE
- Purpose: Confirm search handles missing keys without crashing.
- Procedure:
    1. Call `BPlusTree::search("00000")`.
- Result: Function completes without exception, indicates record not found. Test passed.

TEST 4: SEQUENCE SET SCAN BY STATE
- Purpose: Validate sequential scanning of leaf blocks (linked list) in BSS file.
- Procedure:
    1. Call `searchByState("data/zipCodes.bss", "VI")`.
    2. Traverse linked leaves and print matching records.
- Result: All Virgin Islands records returned. Linked list traversal verified. Test passed.

TEST 5: DUMP TREE
- Purpose: Visualize tree structure for debugging.
- Procedure:
    1. Call `BPlusTree::dumpTree()`.
- Result: Printed index levels and leaf block info. Verified block relationships. Test passed.

Annotated Test Script:
----------------------
%echo "TEST 1: Build B+ Tree"
./project4 --build

%echo "TEST 2: Search Valid ZIP Codes 10001, 90210, 60601"
./project4 -search 10001
./project4 -search 90210
./project4 -search 60601

%echo "TEST 3: Search Invalid ZIP Code 00000"
./project4 -search 00000

%echo "TEST 4: Sequence Set Scan by State VI"
./project4 -state VI

%echo "TEST 5: Dump Tree"
./project4 --dump

Notes:
------
- All tests assume the `data` directory exists and contains `us_postal_codes.csv`.
- Tests cover both B+ Tree random access and BSS sequential leaf scanning.
- Script annotations using `%echo` provide clear description for automated test logs.

Conclusion:
-----------
All tests were executed successfully. The B+ Tree class performs correctly for:
- Building from CSV
- Index-based searches
- Handling missing keys
- Traversing leaf blocks
- Debugging and tree visualization
The system is ready for deployment or further extension.

