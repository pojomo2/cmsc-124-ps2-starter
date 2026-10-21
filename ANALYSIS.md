# Vector and Scalar Evaluation

Let’s use sample_scores <- c(Ada = 8, Grace = NA, Linus = 12, Barbara = 4).

In clean_scores_vector(), I copy the input into out, names included. is.na(out) flags the missing entries in one sweep, giving c(FALSE, TRUE, FALSE, FALSE). Writing 0 into out[missing] only changes Grace’s slot, so out becomes 8, 0, 12, 4. Then !missing selects Ada, Linus, and Barbara. Doubling them gives 16, 24, 8, and pmin(..., 20) stretches the single 20 across all three, capping Linus. The result is Ada = 16, Grace = 0, Linus = 20, Barbara = 8. Grace stays at 0 because she was never part of the doubling step. That’s three vectorized operations, with the iteration done in R’s C internals.

In clean_scores_scalar(), a loop walks i from 1 to 4, handling one length-one value per pass. At i = 1, out[[1]] is 8, is.na says no, and min(16, 20) returns 16. At i = 2, the value is NA, so it becomes 0. At i = 3, doubling gives 24, and min(24, 20) brings it to 20. At i = 4, it ends at 8. Both functions give identical results. Order matters in the loop, though: is.na() must come first, since if (NA) raises an error in R and min(2 * NA, 20) returns NA instead of 0.

The difference is where the logic sits. With vectors, I write each rule once and let logical subsetting choose the elements. With the loop, the rule runs on every element and control flow does the choosing. Since R has no true scalars, out[[i]] is still a length-one vector, so the loop just adds interpreter overhead.

Recycling can quietly change results when a shorter vector is paired with a longer one. The lone 0 and 20 here are harmless because each has length one. But out[missing] <- c(0, 1) would recycle without a warning if the number of selected positions is even, and a short logical index like out[c(TRUE, FALSE)] would grab every other student instead of the NA scores. The loop avoids this because every operation sees only length-one objects.

I’d pick clean_scores_vector(). It’s compact, faster, idiomatic R, and the rule reads clearly. Recycling isn’t a concern since every logical index is built from out. I’d still keep the scalar function as a test oracle, since the two should always agree. Loops earn their place only when each iteration depends on the previous one.