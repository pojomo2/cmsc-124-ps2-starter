# Reasoning Before Execution

Write the rule behind each case before you commit your predictions. Replace
every placeholder line below with one to three sentences that name the rule
producing that case's value, type, length, and dimensions. One rule is enough.
After you run and find a miss, add a short correction entry under that case in a
later commit.

## P01

According to R's implicit coercion hierarchy (logical → integer → double → character), combining a logical, integer, and double value causes all elements to be coerced to `double`. The resulting vector has a length of 3 and carries no dimensions.

---

## P02

According to the coercion ladder, character storage has the highest priority, so all other data values get coerced into characters. It has no `dim` attribute as there are no matrices or arrays, just the three values `["1","2","TRUE"]`.

---

## P03

The `+` operator works position-by-position. When one operand is shorter, R recycles the smaller operand, repeating it from the start (so `1` is used at positions 1 and 3, and `2` at positions 2 and 4). The value is `[11,22,31,42]`, the type is `integer` because it is the only type present, the length is 4 because the result takes the length of the longer operand, and `dim` is `none` because there are no matrices or arrays.

---

## P04

Since indexing in R is 1-based, `3L` selects the 3rd element (`9L`) first, and `1L` selects the 1st element (`8L`) second. The type stays `integer` as specified by the `L` suffix, and length is 2 because the index vector `c(3L, 1L)` requests two positions. The values retain their names, and `dim` is `none` because there is no matrix or array.

---

## P05

Indexing with `-2L` excludes the value at the 2nd position in the vector, leaving `[4,9]`. The type stays `integer` because the remaining elements are still integers, length is 2 because two values remain, and `dim` is `none` as there is no matrix or array.

---

## P06

Subsetting a vector with a logical index vector evaluates each position individually. The `NA` element is included because `NA > 10` evaluates to `NA`, and subsetting with `NA` retains the missing value in the result. The type is `integer`, length is 2 because two values are returned, and `dim` is `none`.

---

## P07

`typeof()` returns `integer` because factors internally store data as 1-based integer codes pointing to positions in the `levels` attribute (where 1 = `"low"` and 2 = `"high"`). The `levels =` argument explicitly sets the order to low then high. The length is 3 because the factor contains 3 elements, and `dim` is `none`.

---

## P08

`typeof()` is `list` because it holds generic vector slots containing different data types without coercing them. Length is 2 because there are two top-level components in the list, and `dim` is `none`.

---

## P09

`typeof()` is `list` because a data frame is physically implemented as a named list of equal-length column vectors. `length()` is 2 because it counts top-level list elements (the columns `id` and `passed`), while `dim()` is `2x2` reflecting the 2 rows and 2 columns.

---

## P10

A matrix is an atomic vector with a `dim` attribute. Arithmetic with `c(10L, 20L)` recycles values column-by-column across the 6 integers, preserving the `integer` type and `2x3` structure.

---

## P11

Because there is a missing value (`NA_real_`) in the input vector without `na.rm = TRUE`, the total mean cannot be calculated and evaluates to missing (`NA`). Since `8`, `10`, and `NA_real_` are double-precision numbers, `mean()` returns a missing `double` value, so its `typeof()` is `double`.

---

## P12

Setting `na.rm = TRUE` instructs `mean()` to strip out missing values like `NA_real_` before calculating. With `NA_real_` removed, `mean()` averages `c(8, 10)`, resulting in `9`. Bare numbers in R default to `double` storage, so the type is `double`.

---

## P13

`1:3` creates an initial `integer` vector `[1, 2, 3]`. Assigning `2.5` (a `double`) to position 2 triggers mixed-mode subassignment, forcing R to coerce all vector elements from `integer` to `double`. The vector retains length 3 with no dimensions.

---

## P14

`ifelse(is.na(scores), 0, scores * 2)` replaces `NA_real_` with `0` while doubling valid scores. The logical subassignment `adjusted[adjusted > 15] <- 15` identifies elements exceeding 15 and caps them at 15. The storage mode remains `double`, length is 4, and `dim` is `none`.

---

## P15

The colon operator `1:8` creates an integer vector of 8 numbers. `array()` wraps those 8 numbers and attaches the 3D dimensions `c(2L, 2L, 2L)`, creating a `2x2x2` structure while maintaining column/slice-major storage, length 8, and `integer` type.

---

## P16

Indexing a vector at position 0 (`0L`) selects no elements and returns an empty result. Indexing preserves the underlying storage mode, returning an empty `integer` vector (`[]`) of length 0 and no dimensions.