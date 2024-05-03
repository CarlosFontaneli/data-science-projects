library(ggplot2)

# DESCRIPTIVE STATISTIC

# minimum and maximum
dat <- ggplot2::mpg
summary(dat$hwy)
min(dat$hwy)
max(dat$hwy)

# histogram
hist(dat$hwy,
  xlab = "hwy",
  main = "Histogram of hwy",
  breaks = sqrt(nrow(dat))
)

ggplot(dat) +
  aes(x = hwy) +
  geom_histogram(bins = 30L, fill = "#0c4c8a") +
  theme_minimal()

# boxplot
boxplot(dat$hwy,
  ylab = "hwy",
  main = "Boxplot of highway milers per gallon"
)
mtext(paste("Outliers: ", paste(out, collapse = ", ")))

ggplot(dat) + # the dots show potential outliers
  aes(x = "", y = hwy) +
  geom_boxplot(fill = "#0c4c8a") +
  theme_minimal()

out <- boxplot.stats(dat$hwy)$out # extract the values of potentital outliers
out_ind <- which(dat$hwy %in% c(out))
out_ind

dat[out_ind, ]

# percentiles
lower_bound <- quantile(dat$hwy, 0.01)
lower_bound

upper_bound <- quantile(dat$hwy, 0.99)
upper_bound

outlier_ind <- which(dat$hwy < lower_bound | dat$hwy > upper_bound)
outlier_ind

dat[outlier_ind, "hwy"]


# Hamppel filter
lower_bound <- median(dat$hwy) - 3 * mad(dat$hwy, constant = 1)
lower_bound

upper_bound <- median(dat$hwy) + 3 * mad(dat$hwy, constant = 1)
upper_bound

outlier_ind <- which(dat$hwy < lower_bound | dat$hwy > upper_bound)
outlier_ind


# STATISTICAL TESTS
library(outliers)

test <- grubbs.test(dat$hwy) # highest value
test

test <- grubbs.test(dat$hwy, opposite = TRUE) # lowest value
test

dat[34, "hwy"] <- 212
test <- grubbs.test(dat$hwy) # highest value
test

# Dixons test
subdat <- dat[1:20, ]

# lowest value
test <- dixon.test(subdat$hwy)
test

# highest value
test <- dixon.test(subdat$hwy,
  opposite = TRUE
)
test

out <- boxplot.stats(subdat$hwy)$out
boxplot(subdat$hwy,
  ylab = "hwy"
)
mtext(paste("Outliers: ", paste(out, collapse = ", ")))
# boxplot shows that 20 could be an outlier aswell

# testing for 20
# find and exclude lowest value
remove_ind <- which.min(subdat$hwy)
subdat <- subdat[-remove_ind, ]

# Dixon test on dataset without the minimum
test <- dixon.test(subdat$hwy)
test

# Rosners test
library(EnvStats)
test <- rosnerTest(dat$hwy, k = 3)
test
test$all.stats

# Aditional remarks
library(mvoutlier)
Y <- as.matrix(ggplot2::mpg[, c("cyl", "hwy")])
res <- aq.plot(Y)