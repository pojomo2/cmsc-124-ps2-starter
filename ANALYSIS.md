# Vector and Scalar Evaluation

Take `sample_scores <- c(Ada = 8, Grace = NA, Linus = 12, Barbara = 4)`.

In `clean_scores_vector()`, `out` is a copy with names preserved. `is.na(out)` scans the whole vector once and returns `c(FALSE, TRUE, FALSE, FALSE)`. `out[missing] <- 0` assigns to position 2 only, giving `8, 0, 12, 4`. `!missing` selects Ada, Linus, and Barbara. `2 * out[!missing]` is `16, 24, 8`, and `pmin(..., 20)` recycles `20` against it, giving `16, 20, 8`. The result is `Ada = 16, Grace = 0, Linus = 20, Barbara = 8`. Grace is neither doubled nor capped because the second assignment excludes her. That is three vector operations, with the looping done in R's C code.

In `clean_scores_scalar()`, the loop runs for `i = 1..4`, handling one length-one value each time. For `i = 1`, `out[[1]]` is `8`, `is.na` is `FALSE`, and `min(16, 20)` yields `16`. For `i = 2`, the value is `NA`, so the result is `0`. For `i = 3`, `min(24, 20)` is `20`. For `i = 4`, the result is `8`. The output matches the vector version. The `is.na()` check must come first, because `if (NA)` is an error in R and `min(2 * NA, 20)` is `NA`, not `0`.

The models differ in where the rule lives. The vector approach states each rule once for all elements and uses logical subsetting to choose where it applies. The scalar approach applies the rule per element and lets control flow decide. R has no true scalars, so `out[[i]]` is still a length-one vector, and the loop only adds interpreter overhead.

Recycling would change the answer when a shorter vector is silently paired with a longer one. The single `0` and `20` here are safe because they have length one. However, `out[missing] <- c(0, 1)` would recycle without a warning whenever the number of selected slots is divisible by two. A logical index shorter than `out` also recycles, so `out[c(TRUE, FALSE)]` would select every other student rather than the NA scores. The scalar loop cannot make this mistake because every operation involves length-one objects.

I would keep `clean_scores_vector()`. It is shorter, faster, idiomatic R, and states the rule clearly. Recycling is not a risk here because every logical index is derived from `out` itself. The scalar version remains useful as a test oracle, since both implementations must agree. A loop is the right tool only when each iteration depends on the previous one.
