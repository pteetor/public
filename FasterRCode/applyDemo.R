#
# 'apply' demo
#
set.seed(666)
M <- matrix(rnorm(12), 3, 4)

M
apply(M, 1, median)
apply(M, 2, median)
