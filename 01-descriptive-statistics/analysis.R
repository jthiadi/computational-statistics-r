# Descriptive statistics of customer ages.
# Run from this folder so the data path resolves:
#   Rscript analysis.R

# Load the data file; header=TRUE means the first row has column names
customers <- read.table("customers.txt", header = TRUE)

# Extract the age column as a vector so we can work with it directly
ages <- customers$age


ages[5]  
# [5] selects the 5th position in the vector, keeping the original order


sort(ages)[5]  
# sort() puts values in increasing order, then [5] selects the 5th smallest


sort(ages)[1:5]  
# 1:5 creates a sequence of indices for the first five sorted values


sort(ages, decreasing = TRUE)[1:5]  
# decreasing=TRUE sorts from largest to smallest, then we take the first five


mean(ages)  
# mean() is a built-in function that computes the arithmetic average


sd(ages)  
# sd() calculates how spread out the ages are around the mean


age_diff <- ages - mean(ages)  
# Subtracting a single value from a vector applies the operation to every element


mean(age_diff)  
# The mean of deviations from the mean is 0 by definition


hist(ages)  
# hist() groups data into bins to show the distribution of values


plot(density(ages))  
# density() estimates a smooth distribution curve from the data


boxplot(ages, horizontal = TRUE)
# boxplot() summarizes the data using quartiles and median

stripchart(ages, method = "stack", add = TRUE)
# stripchart() adds individual data points with slight noise to avoid overlap