# Reasoning Before Execution

Write the rule behind each case before you commit your predictions. Replace
every placeholder line below with one to three sentences that name the rule
producing that case's value, type, length, and dimensions. One rule is enough.
After you run and find a miss, add a short correction entry under that case in a
later commit.

## P01

**Implicit Coercion Hierarchy:** R follows the type hierarchy (`logical` → `integer` → `double` → `character`). Combining mixed types forces all elements to coerce to the highest type present (`double`). `TRUE` becomes `1.0` and `2L` becomes `2.0`, resulting in a `double` vector of length 3 with no dimensions (`dim = none`).

---

## P02

**Character Coercion Priority:** Under R's coercion rules, character storage has top priority, coercing all other values into strings. Combining `1L`, `"2"`, and `TRUE` produces `["1", "2", "TRUE"]`, resulting in a `character` vector of length 3 with no dimensions.

---

## P03

**Vector Recycling & Integer Arithmetic:** The binary `+` operator operates element-wise, recycling the shorter vector to match length 4 (`10, 20, 10, 20`). Adding integer vectors preserves the `integer` type, yielding `[11, 22, 31, 42]` with length 4 and no dimensions.

---

## P04

**1-Based Positive Indexing:** Indexing in R uses 1-based positioning, where `c(3L, 1L)` selects the 3rd element (`9L`) first and the 1st element (`8L`) second while preserving attached names. The output retains its `integer` type, has a length of 2, and carries no dimensions.

---

## P05

**Negative Index Exclusion:** Subsetting with negative integers excludes elements at those 1-based positions. Specifying `-2L` drops the second element, leaving the remaining values as an `integer` vector of length 2 with no dimensions.

---

## P06

**Logical Subsetting & NA Propagation:** Logical subsetting evaluates conditions position-by-position, where missing values in comparison expressions (like `NA > 10L`) evaluate to `NA` and get preserved in the result. Subsetting retains `NA` alongside valid `TRUE` matches as an `integer` vector of length 2 with no dimensions.

---

## P07

**Factor Internal Storage:** `typeof()` returns `integer` because factors are physically stored as 1-based integer codes pointing to an explicit `levels` attribute. The factor contains 3 elements, so its length is 3 and it carries no dimensions.

---

## P08

**Generic List Representation:** `typeof()` returns `list` because generic lists store heterogeneous components in separate top-level slots without coercing their data types. The list has a length of 2 (counting top-level components) and no dimensions.

---

## P09

**Data Frame Implementation:** `typeof()` returns `list` because a data frame is physically implemented as a named list of equal-length column vectors. `length()` returns 2 (counting column vectors), while `dim()` returns `2x2` reflecting 2 rows and 2 columns.

---

## P10

**Matrix Recycling & Column-Major Ordering:** A matrix is an atomic vector stored in column-major order with a 2D `dim` attribute. Arithmetic with `c(10L, 20L)` recycles values down columns, preserving the `integer` type and the `2x3` matrix dimensions.

---

## P11

**Default NA Propagation in Summary Functions:** Because `na.rm` defaults to `FALSE`, any missing value (`NA_real_`) in the input vector causes `mean()` to return missingness. Because non-missing inputs are double-precision numbers, `mean()` returns a missing double (`NA_real_`), having type `double`, length 1, and no dimensions.

---

## P12

**Explicit NA Removal:** Setting `na.rm = TRUE` instructs `mean()` to strip out missing values (`NA_real_`) before aggregation. Averaging the remaining double-precision values (`8` and `10`) yields `9.0`, which is a scalar of type `double`, length 1, and no dimensions.

---

## P13

**Mixed-Mode Subassignment Coercion:** Assigning a `double` value (`2.5`) into an existing integer vector forces implicit whole-vector coercion to `double` to maintain atomic homogeneity. The resulting vector has type `double`, length 3, and no dimensions.

---

## P14

**Vectorized Selection & Subassignment Capping:** `ifelse()` replaces missing values with `0` while doubling valid numeric scores, and logical subassignment (`adjusted[adjusted > 15] <- 15`) caps values exceeding 15 down to 15. The storage mode remains `double`, length is 4, and `dim` is `none`.

---

## P15

**Multi-Dimensional Array Structure:** `array()` attaches a 3D `dim` vector (`c(2L, 2L, 2L)`) to an atomic sequence in column/slice-major order. The output has type `integer`, length 8, and dimensions `2x2x2`.

---

## P16

**Zero Indexing Behavior:** Indexing a vector at position 0 (`0L`) selects no elements and returns an empty result (`integer(0)`). Subsetting preserves the underlying storage mode, returning a vector of type `integer`, length 0, and no dimensions.