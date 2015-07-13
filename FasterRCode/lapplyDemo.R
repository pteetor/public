#
# Demo of 'lapply'
#
set.seed(666)
lst <- list(1, 2, 9)
sqrt(lst)     # Can't do this!
lapply(lst, sqrt)
