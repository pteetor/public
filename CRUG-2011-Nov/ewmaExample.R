#
# EWMA example
#
set.seed(667)
deltas <- rnorm(100)
prices <- cumsum(deltas)

lambda <- 0.95
f <- function(prv,nxt)
       lambda*prv + (1-lambda)*nxt
ewma <- Reduce(f,prices,accumulate=T)

plot(merge.zoo(prices, ewma), plot.type="single",
     xlab="Time", ylab="Price and EWMA",
     col=c("red", "green"), lwd=c(2,2) )

