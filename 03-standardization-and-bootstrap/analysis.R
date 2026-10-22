# Standardization, CI coverage under sampling, and bootstrap CIs for booking times.
# Requires: compstatslib (see ../install-packages.R)
# Run from this folder:
#   Rscript analysis.R

library(compstatslib)
set.seed(42)

# function for standardizing
standardize <- function(numbers) {
  (numbers - mean(numbers)) / sd(numbers)
}


#1a
# create normal distribution  (mean=940, sd=190)
rdata <- rnorm(n = 2000, mean = 940, sd = 190)

# standardize the data
rnorm_std <- standardize(rdata)

# a) i)
# check the mean and standard deviation
mean(rnorm_std)
sd(rnorm_std)

# a) ii)
hist(rdata, prob = TRUE, col = "antiquewhite", main = "Distribution of rdata")
lines(density(rdata), col = "gold", lwd = 3)

hist(rnorm_std, prob = TRUE, col = "lavender", main = "Distribution of rnorm_std")
lines(density(rnorm_std), col = "gold", lwd = 3)

# b) 
bookings <- read.table("first_bookings_datetime_sample.txt", header=TRUE)
bookings$datetime[1:9]
hours  <- as.POSIXlt(bookings$datetime, format="%m/%d/%Y %H:%M")$hour
mins   <- as.POSIXlt(bookings$datetime, format="%m/%d/%Y %H:%M")$min
minday <- hours*60 + mins
plot(density(minday), main="Minute (of the day) of first ever booking", col="blue", lwd=2)

minday_std <- standardize(minday)
plot(density(minday_std), main="Distribution of minday_std", col="gold", lwd=2)

# b) i)
mean(minday_std)
sd(minday_std)

# q2a
plot_sample_ci(num_samples = 100, sample_size = 100, pop_size=10000, distr_func=rnorm, mean=20, sd=3)

# Repeat the experiment 200 times
miss95 <- replicate(200, {

  population <- rnorm(10000, mean=20, sd=3)      # Generate a normal population
  population_mean <- mean(population)            # True population mean
  
  # Count how many of 100 samples miss the population mean
  sum(replicate(100, {
    samp <- sample(population, 100)               # Draw a sample of size 100
    standard_error <- sd(samp)/sqrt(100)          # Compute standard error
    ci <- mean(samp) + c(-1.96,1.96)*standard_error # Construct 95% CI
    population_mean < ci[1] || population_mean > ci[2] # Check if CI misses the true mean
  }))
})

# Repeat the experiment 200 times
miss99 <- replicate(200, {

  population <- rnorm(10000, mean=20, sd=3)      # Generate a normal population
  population_mean <- mean(population)            # True population mean
  
  # Count how many of 100 samples miss the population mean
  sum(replicate(100, {
    samp <- sample(population, 100)               # Draw a sample of size 100
    standard_error <- sd(samp)/sqrt(100)          # Compute standard error
    ci <- mean(samp) + c(-2.58,2.58)*standard_error # Construct 99% CI
    population_mean < ci[1] || population_mean > ci[2] # Check if CI misses the true mean
  }))
})

mean(miss95)
mean(miss99)


# q2b
plot_sample_ci(num_samples = 100, sample_size = 300, pop_size=10000, distr_func=rnorm, mean=20, sd=3)

# repeat the experiment 200 times
miss95_b <- replicate(200, {
  population <- rnorm(10000, mean=20, sd=3)
  population_mean <- mean(population) # true population mean
  
  # count how many of 100 samples miss the population mean
  sum(replicate(100, {
    samp <- sample(population, 300) # sample of size 100
    standard_error <- sd(samp)/sqrt(300) # compute standard error

    # 95% CI formula (z-value: 1.96)
    ci <- mean(samp) + c(-1.96,1.96)*standard_error 

    # check if CI misses the true mean
    population_mean < ci[1] || population_mean > ci[2] 
  }))
})

# calculate average
mean(miss95_b)

#q2c
plot_sample_ci(num_samples = 100, sample_size = 100, pop_size=10000, distr_func=runif)

plot_sample_ci(num_samples = 100, sample_size = 300, pop_size=10000, distr_func=runif)
# repeat the experiment 200 times
miss95_c <- replicate(200, {
  population <- runif(10000) 
  population_mean <- mean(population) # true population mean
  
  # count how many of 100 samples miss the population mean
  sum(replicate(100, {
    samp <- sample(population, 100) # sample of size 100
    standard_error <- sd(samp)/sqrt(100) # compute standard error

    # 95% CI formula (z-value: 1.96)
    ci <- mean(samp) + c(-1.96,1.96)*standard_error 

    # check if CI misses the true mean
    population_mean < ci[1] || population_mean > ci[2] 
  }))
})

# calculate average
mean(miss95_c)

# repeat the experiment 200 times
miss99_c <- replicate(200, {
  population <- runif(10000) 
  population_mean <- mean(population) # true population mean
  
  # count how many of 100 samples miss the population mean
  sum(replicate(100, {
    samp <- sample(population, 100) # sample of size 100
    standard_error <- sd(samp)/sqrt(100) # compute standard error

    # 99% CI formula (z-value: 2.58)
    ci <- mean(samp) + c(-2.58,2.58)*standard_error 

    # check if CI misses the true mean
    population_mean < ci[1] || population_mean > ci[2] 
  }))
})

# calculate average
mean(miss99_c)
#q3a i
#q3a i
mean_minday <- mean(minday) # estimation of population mean
se_minday <- sd(minday) / sqrt(length(minday)) # standard error

ci_lower <- mean_minday - 1.96 * se_minday # lower limit of 95% CI
ci_upper <- mean_minday + 1.96 * se_minday # upper limit of 95% CI

mean_minday
se_minday
c(ci_lower, ci_upper)

# q3a ii
compute_sample_mean <- function(sample0){
  resample <- sample(sample0, length(sample0), replace=TRUE) # bootstrap resample
  mean(resample) # mean of resampled data
}

bootstrap_means <- replicate(2000, compute_sample_mean(minday)) # generate 2000 bootstrap sample means

# q3a iii
hist(bootstrap_means,
     main="Means of the 2000 bootstrapped samples",
     col="lavender")


# q3a iv
quantile(bootstrap_means, c(0.025, 0.975))

# q3b i
median_minday <- median(minday)
median_minday

# q3b ii
compute_sample_median <- function(sample0){
  resample <- sample(sample0, length(sample0), replace=TRUE)  
  median(resample)                                            
}

# generate 2000 bootstrap medians
bootstrap_medians <- replicate(2000, compute_sample_median(minday))

hist(bootstrap_medians,
     main="Medians of the 2000 bootstrapped samples",
     col="lavender")                                            

quantile(bootstrap_medians, c(0.025, 0.975))                       # Bootstrap 95% CI for median