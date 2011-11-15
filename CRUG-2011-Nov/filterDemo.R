#
# Filter demo
#
set.seed(666)

x <- sample(1:100, 5, replace=TRUE)

x
odd <- function(n) n %% 2 == 1
Filter(odd, x)
