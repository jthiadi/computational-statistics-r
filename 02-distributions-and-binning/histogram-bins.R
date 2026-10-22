# Histogram bin-width rules: Sturges, Scott, and Freedman–Diaconis.
# Run from this folder:
#   Rscript histogram-bins.R

set.seed(42)

# generate random normal distribution
n <- 800
rand_data <- rnorm(n, mean=20, sd=5)

# Calculate Range for k/h conversions
range <- max(rand_data) - min(rand_data)

# Sturges' Formula
k_sturges <- ceiling(log2(n) + 1)
h_sturges <- range / k_sturges
print(k_sturges)
print(h_sturges)


# Scott's Normal Reference Rule
h_scott <- (3.49 * sd(rand_data)) / (n^(1/3))
k_scott <- ceiling(range / h_scott)
print(h_scott)
print(k_scott)

# Freedman-Diaconis' Choice
h_fd <- (2 * IQR(rand_data)) / (n^(1/3))
k_fd <- ceiling(range / h_fd)
print(h_fd)
print(k_fd)


#LAST
out_data <- c(rand_data, runif(10, min=40, max=60)) 
range2 <- max(out_data) - min(out_data)

n2 <- length(out_data)

# Sturges' Formula
k_sturges2 <- ceiling(log2(n2) + 1)
h_sturges2 <- range2 / k_sturges2
print(k_sturges2)
print(h_sturges2)

# Scott's Normal Reference Rule
h_scott2 <- (3.49 * sd(out_data)) / (n^(1/3))
k_scott2 <- ceiling(range2 / h_scott2)
print(h_scott2)
print(k_scott2)

# Freedman-Diaconis' Choice
h_fd2 <- (2 * IQR(out_data)) / (n2^(1/3))
k_fd2 <- ceiling(range2 / h_fd2)
print(h_fd2)
print(k_fd2)

print