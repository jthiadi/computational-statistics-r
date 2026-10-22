# Simulated mixtures vs symmetric normals: density, mean/median, quartile z-scores.
# Run from this folder:
#   Rscript analysis.R

set.seed(42)

plot_distribution <- function(data, title) {
  # plot the density function of data
  plot(density(data), col="blue", lwd=2, main = title)
  
  # add vertical lines showing mean (solid) and median (dashed)
  abline(v = mean(data))
  abline(v = median(data), lty = "dashed")
}

# Three normally distributed data sets
d1 <- rnorm(n=500, mean=45, sd=5)
d2 <- rnorm(n=200, mean=30, sd=10)
d3 <- rnorm(n=100, mean=15, sd=15)

# Combine datasets
d123 <- c(d1, d2, d3)
plot_distribution(d123, "Distribution 2")

# Single normally distributed dataset
d_symmetric <- rnorm(n=800, mean=30, sd=10)
plot_distribution(d_symmetric, "Distribution 3")

#q2

plot_distribution2 <- function(data, title) {
  # plot the density function of data
  plot(density(data), col="blue", lwd=2, main=title)
  
  # calculate mean and standard deviation
  m <- mean(data)
  s <- sd(data)
  
  # for mean (solid)
  abline(v = m)
  
  # 1st, 2nd, and 3rd standard deviations left and right (dashed)
  abline(v = c(m-s, m-2*s, m-3*s, m+s, m+2*s, m+3*s), lty="dashed")
}

#Q2A
rdata <- rnorm(n=2000, mean=0, sd=1)
plot_distribution2(rdata, "Standard Normal Distribution (Q2A)")

#Q2B
# find the 1st, 2nd, 3rd quartiles
q_rdata <- quantile(rdata, c(0.25, 0.50, 0.75))

# calculate SDs away from mean (Z-scores) 
z_rdata <- (q_rdata - mean(rdata)) / sd(rdata)

print(q_rdata)
print(z_rdata)

#Q2C
# create the new random dataset
rdata_new <- rnorm(n=2000, mean=35, sd=3.5)

# find the 1st, 3rd quartiles
q_new <- quantile(rdata_new, c(0.25, 0.75))

# calculate SDs away from mean (Z-scores) 
z_new <- (q_new - mean(rdata_new)) / sd(rdata_new)

print(z_new)

#Q2D
q_d123 <- quantile(d123, c(0.25, 0.75))
z_d123 <- (q_d123 - mean(d123)) / sd(d123)

print(z_d123)