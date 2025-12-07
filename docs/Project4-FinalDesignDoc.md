# Final Design Document: Project 4

## Project Overview

This project implements a **B+ Tree on top of a Blocked Sequence Set (BSS)** file to index U.S. ZIP code data. The system efficiently stores, searches, and retrieves postal records with both **random access** (via B+ Tree) and **sequential access** (via the doubly-linked leaf nodes of BSS).

The system includes:

1. **BPlusTree class** – builds and manages a static B+ Tree.
2. **BSSFile / BSSBlock / BSSFileHeader classes** – manage the storage, block organization, and file metadata.
3. **ZipCodeRecordBuffer** – handles individual ZIP code records.
4. **IndexManager / BSSIndex / BTreeIndexBlock** – support indexing and searching.
5. **main.cpp** – test driver and CLI interface.

---

## Class Design

### BPlusTree

* **Responsibilities:**

  * Build a B+ Tree from sorted CSV or binary data (static load).
  * Search for a ZIP code using tree traversal.
  * Dump tree structure for debugging.

* **Key Attributes:**

  * `BSSFile bssFile`: Interface to the BSS storage.
  * `int rootRBN`: Relative Block Number of the root node.

* **Key Methods:**

  * `void build(const string& bssFileName, const string& inputCsv)`: Builds the tree.
  * `void search(const string& zipCode)`: Search for a record using B+ Tree.
  * `void dumpTree()`: Display tree structure for debugging.
  * `vector<pair<string,int>> writeIndexLevel(...)`: Helper to build internal index layers.

---

### BSSFile / BSSBlock / BSSFileHeader

#### BSSFileHeader

* Stores metadata: block size, record count, root RBN, min capacity, field schemas.
* Methods to read/write the header to disk.

#### BSSBlock

* Represents a single fixed-size block in the BSS.
* Holds records and provides methods to pack/unpack.
* Supports making a block an "avail" block in the free list.

#### BSSFile

* Manages file operations (read/write blocks, maintain avail list).
* Methods to add/delete records, split/merge blocks.
* Provides access to the BSS header.

---

### BTreeIndexBlock

* Represents internal nodes of the B+ Tree.
* Stores entries: `{key, rbn}` pairs.
* Methods:

  * `addEntry(key, rbn)`: Add a key/RBN to block.
  * `search(key)`: Find child RBN for traversal.
  * `pack/unpack`: Serialize/deserialize block.
  * `write/read`: Persist block to disk.

---

### BSSIndex / IndexManager

* Support structures for efficient lookup:

  * **BSSIndex**: Maps highest key → RBN for quick BSS scanning.
  * **IndexManager**: Maintains ZIP → byte offset mapping for binary data.

---

### ZipCodeRecordBuffer

* Represents a single ZIP code record.
* Supports:

  * `pack() / unpack()`: Convert to/from CSV string.
  * `ReadRecord()`: Read a record from file stream, skipping invalid lines.
  * Accessor methods: `getZipCode()`, `getPlaceName()`, `getState()`, etc.

---

### main.cpp (Test Driver / CLI)

* Command-line interface supporting:

  * `--build`: Build B+ Tree from CSV/binary file.
  * `-search <zipcode>`: Search ZIP using B+ Tree.
  * `-state <state>`: Sequential scan by state using linked BSS leaf nodes.
  * `--dump`: Dump tree structure.
  * `--test`: Automated test sequence covering multiple operations.

---

## Data Flow

1. Check if binary data exists (`newBinaryPCodes.dat`), rebuild from CSV if missing.
2. Build BSS Sequence Set (`zipCodes.bss`) and populate leaf blocks.
3. Build B+ Tree index on top of BSS:

   * Create `BTreeIndexBlock` nodes recursively.
   * Store highest keys and RBNs for internal nodes.
4. Searching:

   * B+ Tree: Traverse internal nodes → leaf node → retrieve record.
   * Sequence Set: Sequential scan of linked leaf blocks.

---

## File Structure

```
Project4/
├─ data/                # CSV and binary files
├─ docs/                # Documentation
├─ headers/             # Header files for all classes
├─ src/                 # Source files
```

---

## Summary

* The design separates **storage**, **indexing**, and **record management** cleanly.
* The B+ Tree supports **fast searches**, while the BSS allows **sequential access**.
* `main.cpp` provides a **CLI and automated test driver** to validate functionality.
* The modular class design ensures **extensibility and maintainability** for future projects.
