#
# Demonstration of TLS hedge ratio vs OLS hedge ratio
#
library(quantmod)

getCloses <- function(sym) {
  ohlc <- getSymbols(sym, from="2009-01-01", to="2011-01-01",
                     auto.assign=FALSE, return.class="zoo")
  Cl(ohlc)
}
closes <- merge(IWM=getCloses("IWM"),
                VXZ=getCloses("VXZ"), all=FALSE)

olsHedgeRatio <- function(p, q) {
  m <- lm(p ~ q)
  coef(m)[2]
}

tlsHedgeRatio <- function(p, q) {
  r <- princomp( ~ p + q)
  r$loadings[1,1] / r$loadings[2,1]
}

with(closes, {
  cat("OLS for IWM vs. VXZ =", olsHedgeRatio(IWM,VXZ), "\n")
  cat("OLS for VXZ vs. IWM =", olsHedgeRatio(VXZ,IWM), "\n")
  cat("TLS for IWM vs. VXZ =", tlsHedgeRatio(IWM,VXZ), "\n")
  cat("TLS for VXZ vs. IWM =", tlsHedgeRatio(VXZ,IWM), "\n")
})

# These next lines remind us that TLS does not necessarily
# produce the minimum-variance spread
cat("\n")
with(closes, {
  cat("Std dev of OLS-based hedge =", sd(IWM - olsHedgeRatio(IWM,VXZ)*VXZ), "\n")
  cat("Std dev of TLS-based hedge =", sd(IWM - tlsHedgeRatio(IWM,VXZ)*VXZ), "\n")
})

pdf(file="hedgeRatioDemo.pdf",
		onefile=FALSE,
		pointsize=12 )
plot(closes, plot.type="single", lty=c("solid", "dashed"),
     main=paste(colnames(closes), collapse=" vs. "),
     xlab="Time", ylab="Close")
grid()
legend("bottomright", colnames(closes), lty=c("solid", "dashed"))
dev.off()
