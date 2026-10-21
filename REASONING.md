# Reasoning Before Execution

Write the rule behind each case before you commit your predictions. Replace
every placeholder line below with one to three sentences that name the rule
producing that case's value, type, length, and dimensions. One rule is enough.
After you run and find a miss, add a short correction entry under that case in a
later commit.

## P01
Coercion: a vector holds one type, so `c()` promotes logical < integer < double. TRUE becomes 1 and 2L becomes 2, giving a double vector of length 3 with no dim.

## P02
Coercion: character is the top of the hierarchy, so everything becomes a string. 1L becomes "1" and TRUE becomes "TRUE", giving a character vector of length 3.

## P03
Recycling: the length-2 vector repeats to length 4 (1,2,1,2) and is added elementwise. Integer plus integer stays integer: 11,22,31,42.

## P04
Positive indexing keeps names. Picking positions 3 then 1 returns third=9, first=8 in that order, as an integer vector of length 2.

## P05
A negative index drops that position. Removing position 2 leaves 4 and 9, still integer, length 2.

## P06
`TRUE | NA` is TRUE, so the NA element passes the filter along with 12 (`NA > 10L` is NA, but `is.na(x)` is TRUE). Logical indexing then returns NA and 12, integer, length 2.

## P07
A factor is stored as an integer vector of level codes with a levels attribute, so `typeof` is integer. Its length is 3 (one per element) and it has no dim; levels are low, high in the given order.

## P08
A list holds elements of different types. It has two named elements (scores and label), so `typeof` is list and length is 2, with no dim.

## P09
A data frame is a list of equal-length columns, so `typeof` is list and `length` is the number of columns, 2. It is the only case here where `dim` is defined by the class: 2 rows by 2 columns.

## P10
`matrix(1:6, nrow = 2)` is 2x3, filled column by column. The length-2 vector recycles down the columns (10,20,10,20,10,20), giving 11,22,13,24,15,26, integer, length 6.

## P11
Any NA in the input makes `mean()` return NA, since `na.rm` defaults to FALSE. `mean` returns a double, so it is NA_real_ with length 1.

## P12
`na.rm = TRUE` drops the NA first, so the mean of 8 and 10 is 9. It is a double of length 1.

## P13
Assigning 2.5 into an integer vector coerces the whole vector to double. The result is 1, 2.5, 3 with length 3.

## P14
`ifelse` gives 14, 0, 24, 8 (NA becomes 0, others doubled). Values above 15 are then capped, so 24 becomes 15, leaving 14,0,15,8 as a double of length 4.

## P15
`array` with dim 2x2x2 fills in column-major order with 1 through 8. It stays integer, length 8, and dim is 2x2x2.

## P16
Index 0 selects nothing, so the result is an empty integer vector: length 0, no dim.
