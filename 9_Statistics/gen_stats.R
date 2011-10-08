
#***************************************************************************
#***************************************************************************
#********************** Chapter 9: General Statistics **********************
#***************************************************************************
#***************************************************************************

# to use R completely, then use it for stats and models or graphics.
# 
# Stats test let you choose between two competing hypotheses. 
# Confidence intervals reflect the likely range of a population parameter and
# are calculated based on your data sample.

# Null Hypo, Alt Hypo, and p-Values:

# many of the tests in this chapter use some old-school battle tested ideas. in
# the paradigm, we have one or two data samples. We also have two competing
# hypotheses, either of which could reasonably be true. 

# one hypo, called the null hypo, is that nothing happened: 
# -the mean was unchanged
# -the treatment had no effect
# -you got the expected answer
# -the model did not improve
# -and so forth

# The other hypo, called the alt hypo, is that something did happen:
# -the mean rose
# -the treatment improved the patients' health
# -you got an unexpected answer
# -the model fit better
# -and so forth

# We want to determine which hypo is more likely in light of the data:

# 1. to begin, we assume that the null hypo is true

# 2. we calc a test statistic. it could be something simple, such as the mean of
# the sample, or it could be quite complex. The critical requirement is that we
# must know the statistic's distribution. We might know the distribution of the
# sample mean, for example, by invoking the Central Limit Theorem

# 3. From the statistic and its distribution we can calculate a p-value, the 
# probability of a test statistic value as extreme or more extreme than the one
# we observed, while assuming that the null hypo is true.

# 4. If the p-value is too small, we have strong evidence against the null
# hypothesis. This is called rejecting the null hypothesis.

# 5. If the p-value is not small when we have no such evidence. This is called
# failing to reject the null hypothesis.

# There is one necessary decision here: When is the p-value too small?
# This book follows the convention that we reject the null hypo when p<0.05 and
# fail to reject it when p>0.05. In stats terminology, we choose a significance
# level of alpha = 0.05 to define a border between strong evidence and
# insufficient evidence against the null hypothesis.

# But the real answer too how small should p be to reject the null hypothesis is
# 'it depends'.
# Your chosen significance level depends on your problem domain. The
# conventional limit is p<0.05. In the author's domain which contains noisy
# data, he's often satisfied with p<0.10.
# If you work in high-risk areas, you might need p<0.01 or p<0.001.

# Confidence Intervals:
# ---------------------------------------------------------------------------

# Hypothesis testing is a well-understood mathematical procedure, but it can be
# frustrating. 
# 1 - the semantics are tricky. The test does not reach a definite, useful
# conclusion. You might get strong evidence against the null hypothesis, but
# that's all you'll get. Second, it does not give you a number, only evidence. 

# If you want numbers then use confidence intervals, which bound the estimate of
# a population parameter at a given level of confidence. Recipes in this chapter
# can calculate confidence intervals for measn, medians, and proportions of a
# population.

# For example, Recipe 9.9 calculates a 95% confidence interval for the
# population mean based on the sample data. The interval is 97.16 < mu < 103.98.

# Which means there is a 95% probability that the population's mean, mu, is
# between 97.16 and 103.98

#***************************************************************************
#********************* Chapter 9.1: Summarizing Your Data ******************
#***************************************************************************

# You want a basic statistical summary of your data.

summary(vec)

# To summarize a list of vectors, apply summary to each list element
lapply(vec.list, summary)

#***************************************************************************
#**************** Chapter 9.2: Calculatig Relative Frequencies *************
#***************************************************************************
# You want to count the relative frequency of certain observations in your 
# sample

# Identify the interesting observations by using a logical expression; then use
# the mean function to calculate the fraction of observations it identifies. For
# example, given a vector x, you can find the relative frequency of position
# values in this way

mean(x > 0)

# A logical expression such as (x > 0) produces a vector of logical values, one
# for each element of x.

# The mean function converts those values to 1s and 0s, respectively, and
# computes the average. This gives the the fraction of values that are TRUE -
# in other words, the relative frequency of the interesting values. 

mean(lab == 'NJ') # fraction of lab that equals New Jersey
mean(after > before) # fraction of observations for which the effect increases
mean(abs(x - mean(x)) > 2 * sd(x)) # fraction of obs that are greater than 2
                                   # standard deviations from the mean
mean(diff(ts) > 0) # fraction of observations in a time series that are larger
# than the previous observation
# diff lags the time series

#***************************************************************************
#***** Chapter 9.3: Tabulating Factors and Creating Contingency Tables *****
#***************************************************************************

# You want to tabulate one factor or to build a contingency table from multiple
# factors
# The table function produces counts of one factor
table(f)

# It can also produce contingency tables (cross-tabulations) from two or more
# factors
table(f1, f2)

# xtabs can also produce a contingency table. It has a better interface, which
# some people prefer

#***************************************************************************
#***** Chapter 9.4: Testing Categorical Variables for Independence *********
#***************************************************************************
# You have two categorical variables that are represented by factors. You want
# to test them for independence using the chi-squared test.

# Use the table function to produce a contingency table from two factors. The 
# use the summary function to perform a chi-squared test of the contingency
# table.

summary(table(fac1, fac2))

The output includes a p-value. Conventionallyo, a p-value of less than 

# This example performs a chi-squared test on the contingency table of Recipe
# 9.3 and yields a p-value of 0.01255.

# The output includes a p-value. Conventionally, a p-value of less than 0.05 
# indicates that the variables are likely not independent whereas a p-value
# exceeding 0.05 fails to provide any such evidence.

# This example performs a chi-squared test on the contingency table of Reciple
# 9.3 and yields a p-value of 0.01255.

summary(table(initial, outcome))
# Number of cases in table: 100
# Number of factors: 2
# Test for independence of all factors:
#     Chisq: 8.757, df = 2, p-value = 0.01255

# The small p-value indicates that the two factors, initial and outcome, are
# probably not independent. Practically speaking, we conclude there is some
# connection between the variables.

# See Also:
# the chisq.test function can also perform this test.

#***************************************************************************
#***** Chapter 9.5: Calculating Quantiles (and Quartiles) of a Dataset *****
#***************************************************************************

# Given a fraction f, you want to know the corresponding quantile of you data.
# That is, you seek the observation x such that the fraction of observations
# below x is f.

# Use the quantile function. The second argument is the fraction, f
quantile(vec, f)

For quartiles, simply omit the second argument altogether
quantile(vec)

#***************************************************************************
#******************* Chapter 9.6: Inverting a Quantile *********************
#***************************************************************************

# Given an observation x from your data, you want to know its corresponding
# quantile. That is, you want to know what fraction of the data is less than x.

# Assuming your data is in a vector vec, compare the data against the 
# observation and then use mean to copmuter the relative frequency of values
# less than x. 

mean(vec < x)

# The expression vec < x compares every element of vec against x and returns a
# vector of logical values, where the n-th logical value is TRUE if vec[n] < x.
# The mean function converts those logical values to 0 and 1: 0 for FALSE and 1
# for TRUE.

# The average of all those 1s and 0s is the fraction of vec that is less than x,
# or the inverse quantile of x.

#***************************************************************************
#******************* Chapter 9.7: Conversting Data to Z-Scores *************
#***************************************************************************

# You have a dataset, and you want to calculate the corresponding z-scores for
# all data elements. (Also called normalizing the data)

Use the scale function
scale(x)

# This works for vectors, matrices, and data frames. In the case of a vector,
# scale returns the vector of normalized values. In the case of matrices and
# data frames, scale normalizes each column independently and returns columns of
# normalized values in a matrix.

# You might also want to normalize a single value relative to a dataset x. That
# can be done by using vectorized operations as follows
(y - mean(x)) / sd(x)

#***************************************************************************
#************* Chapter 9.8: Testing the Mean of a Sample (t Test) **********
#***************************************************************************

# You have a sample from a population. Given this sample, you want to know if
# the mean of the population could reasonably be a particular value m.

# Apply the t.test function to the sample x with the argument mu = m
t.test(x, mu = m)

# THe output includes a p-value. Conventionally, if p < 0.05 then the population
# mean is unlikely to be m whereas p > 0.05 provides no such evidence.

# If your sample size n is small, then the underlying population must be
# normally distributed in order to derive meaningful results from the t test. A
# good rule of thumb is small means n < 30.

# The t test is a workhorse of statistics, and this is one of its basic uses:
# making inferences about a population mean from a sample. The following example
# simulates sampling from a normal population with mean mu = 100. It uses the t
# test to ask if the population mean be 95, and t.text reports a p-value of
# 0.001897.

x <- rnorm(50, mean = 100, sd = 15)
t.test(x, mu = 95)

# Note: output and discussion do not have the same numbers, as the random
# vectors we use and the ones used in the book have different seeds.
# Nonetheless, use your imagination.

#         One Sample t-test
# 
# data:  x 
# t = 1.7676, df = 49, p-value = 0.08335
# alternative hypothesis: true mean is not equal to 95 
# 95 percent confidence interval:
#   94.43821 103.77104 
# sample estimates:
# mean of x 
#  99.10462 

# The p-value is small and so it's unlikely (based on the sample data) that 95
# could be the mean of the population

# Informally, we could interpret the low p-value as follows. If the population
# mean were really 95, then the probability of observing our test statistic 
# (t = 3.2832 or something more extreme) would be only 0.001897. That is very
# improbable, yet that is the value we observed. Hence we conclude that the null
# hypothesis is wrong; therefore, the sample data does not support the claim
# that the population mean is 95.

# In sharp contrast, testing for a mean of 100 gives a p-value of .7374.
t.test(x, mu = 100)

#         One Sample t-test
# 
# data:  x 
# t = -0.3856, df = 49, p-value = 0.7015
# alternative hypothesis: true mean is not equal to 100 
# 95 percent confidence interval:
#   94.43821 103.77104 
# sample estimates:
# mean of x 
#  99.10462 

# The large p-value indicates that the sample is consistent with assuming a
# population mean mu of 100. In stat terms, the data does not provide evidence
# against the true mean being 100.

# A common case is testing for a mean of zero. If you omit the mu argument, it
# defaults to zero

# See 9.9 and 9.15 for more t-test goodness

#***************************************************************************
#************* Chapter 9.9: Testing the Mean of a Sample (t Test) **********
#***************************************************************************
# You have a sample from a population. Given that sample, you want to determine
# a confidence interval for the population's mean.

# Apply the t.test function to your sample x:
# The output includes a confidence interval at the 95% confidence interval. To
# see intervals at other levels, use the conf.level argument.

# If your sample size n is small, then the underlying population must be
# normally distributed for there to be a meaningful confidence interval. Again,
# a good rule of thumb is that 'small' means n < 30.

# Applying the t.test function to a vector yields a lot of output. Buried in the
# output is a confidence interval:

x <- rnorm(50, mean = 100, sd = 15)
t.test(x)
t.test(x, conf.level = 0.99) # widens the confidence interval

#***************************************************************************
#********* Chapter 9.10: Forming a Confidence Interval for a Mediean *******
#***************************************************************************

# You have a data sample, and you want to know the confidence interval for the
# median.

# Use the wilcox.test function, setting conf.int = TRUE:
wilcox.test(x, conf.int = TRUE)

# The output will contain a confidence interval for the median.

# The procedure for calculating the confidence interval of a mean is
# well-defined and widely known. The same is not true for the median. There are
# several procedures for calc'ing the the median's confidence interval. None of
# them are 'the' procedure as far as the author know, but the Wilcoxon signed
# rank test is pretty standard.

# The wilcox.test function implements that procedure. Buried in the output is
# the 95% confidence interval, which is approximately (0.424, 0.892) in this
# case:

wilcox.test(x, conf.int = TRUE)

#         Wilcoxon signed rank test with continuity correction
# 
# data:  x 
# V = 1275, p-value = 7.79e-10
# alternative hypothesis: true location is not equal to 0 
# 95 percent confidence interval:
#   94.98535 102.34358 
# sample estimates:
# (pseudo)median 
#       98.70912 

# You can change the confidence level by setting conf.level, such as 
# conf.level = 0.99 or other such values.

# The output also includes something called the pseudomedia, which is defined
# on the help page. It is not the median - they are different. 

# The bootstrap procedure is also useful for estimating the median's confidence
# interval. See 8.5 and 13.8

#***************************************************************************
#*************** Chapter 9.11: Testing a Sample Proportion *****************
#***************************************************************************

# You have a sample of values from a population consisting of a successes and
# failures. You believe the true proportion of successes is p, and you want to
# test the hypothesis using the sample data.

# Use the prop.text function. Suppose the sample size is n and the sample
# contains x successes:

prop.test(x, n, p)

# The output includes a p-value. Conventionally, a p-value of less than 0.05
# incidates that the true proportion is unlikely to be p whereas a p-value
# exceeding 0.05 fails to provide such evidence.

# Suppose you encounter a Cubs fan early in the season. The Cubs have played 20
# games and won 11 of them, or 55% of their games. Based on that, the fan is
# very confident the Cubs will win more than 1/2 their games. Should he be that
# confident?

# The prop.test function can evaluate the fan's logic. Here, the number of
# observations is n = 20, the number of successes is x = 11, and p is the true
# probability of winning a game. We want to know whether it is reasonable to
# conclude, based on the data, that p > 0.5. Normally the prop.text would check
# for p != 0.05, but we can check for p > 0.5 instead by setting
# alternative = 'greater'.

prop.test(11, 20, 0.5, alternative = 'greater')

#         1-sample proportions test with continuity correction
# 
# data:  11 out of 20, null probability 0.5 
# X-squared = 0.05, df = 1, p-value = 0.4115
# alternative hypothesis: true p is greater than 0.5 
# 95 percent confidence interval:
#  0.349615 1.000000 
# sample estimates:
#    p 
# 0.55 

# The prop.test shows a large p-value, 0.4115, so we cannot reject the null
# hypothesis; that is, we cannot reasonably conclude that p is greater than 1/2.
# the Cubs fan is being overly confident based on too little data. No surprise
# there. 


#***************************************************************************
#******* Chapter 9.12: Forming a Confidence Interval for a Proportion ******
#***************************************************************************
# You have a sample of values from a population consisting of successes and
# failures. Based on the sample data, you want to form a confidence interval for
# the populations's proportion of successes.

# Use the prop.test function. Suppose the sample size is n and the sample
# contais x successes:
prop.test(n, x)

# I subscribe to a stock market newsletter that is well written for the most
# part but includes a section purporting to identify stocks likely to rise. It
# does this by looking for a certain pattern in the stock price. It recently
# reported, for example, that a certain stock was following a pattern. It also
# reported that the stock rose six times after the last nine times that pattern
# occurred. The writers concluded that the probability of the stock rising again
# was therefore 6/9 or 66.7%.

# Using prop.test, we can obtain the confidence interval for the true proportion
# of times the stock rises after the pattern. Here, the number of observations
# is n = 9, and the number of successes is x = 6. The output shows a confidence
# interval of (0.309, 0.910) at the 95% confidence interval.

prop.test(6, 9)

# The writers are foolish to say the probability of rising is 66.7%. They could
# be leading the readers into a very bad bet. 

# By default, prop.test calculates a confidence interval at the 95% confidence
# level. Use the conf.level argument for other confidence levels.

prop.test(n, x, p, conf.level = 0.99)

#***************************************************************************
#******* Chapter 9.13: Testing for NormalityInterval for a Proportion ******
#***************************************************************************

# You want a statistical test to determine whether your data sample is from a
# normally distributed population.

# Use the shapiro.test function
shapiro.test(x)

# The output includes a p-value. Conventionally, p < 0.05 indicates that the
# population is likely not normally distributed whereas p > 0.05 provides no
# such evidence.

# This example reports a p-value of .4151 for x (depends on random seed)
shapiro.test(x)

#         Shapiro-Wilk normality test
# 
# data:  x 
# W = 0.984, p-value = 0.7267

# The large p-value suggests the underlying population could be normally
# distributed. The next exapmle reports a small p-value for y, so it is unlikely
# that this sample came from a normal population.
shapiro.test(y)

# The author highlighted the Shapiro-Wilk teste because it is a a standard R
# function. You can also install the package nortest, which is dedicated
# entirely to tests for normality. That package includes:

# Anderson-Darling test
# Cramer-von Mises test
# Lilliefor test
# Pearson chi-squared test for composite hypothesis of normality (pearson.test)
# Shapiro - Francia test (sf.test)

# THe problem with all these tests is their null hypothesis: they all assume
# that the population is normally distributed until proven otherwise. As a
# result, the population must be decidenly non-normal before the test reports a
# small p-value and you can reject that null hypothesis. That makes the tests
# quite conservative, tending to err on the side of normality.

# Instead of depending solely upon a statistical test, also use histograms and
# quantile-quantile plots to evaluate the normality of any data. THe tails too
# fat? The peak too peaked? Use your judgment

#***************************************************************************
#*********************** Chapter 9.14: Testing for Runs ********************
#***************************************************************************

# Your data is a sequnce of binary values: yes-no, 0-1, true-false, or other
# two-valued data. You want to know: Is the sequence random?

# The tseries package contains the runs.test function, which checks a sequence
# for randomness. The sequence should be a factor with two levels
require(tseries)
runs.test(as.factor(s))

# The runs.test function reports a p-value. Conventionally, a p-value of less
# than 0.05 indicates that the sequence is likely not random whereas a p-value
# exceeding 0.05 provides no such evidence.

# A run is a subsequence composed of identical values, such as all 1s or all 0s.
# A random sequence should be properly jumbled up, without too many runs.
# Similarly, it shouldn't contain too few runs, either. A sequence of perfectly
# alternating values (0, 1, 0, 1, 0...) contains no runs, but it's certainly not
# random.

# The runs.test function checks the number of runs in your sequence. If there
# are too many or too few, it reports a small p-value.

# This first example generates a random sequence of 0s and 1s and then tests the
# sequence for runs. Not suprisingly, runs.test reports a large p-value
# indicating the sequence is likely random.

s <- sample(c(0, 1), 100, replace = T)
runs.test(as.factor(s))

# This next sequence, however, consists of three runs and so the reported
# p-value is quite low.

s <- c(0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0)
runs.test(as.factor(s))

# See also 5.4 and 8.6

#***************************************************************************
#************** Chapter 9.15: Comparing the Means of Two Samples ***********
#***************************************************************************

t.test(x, y)

# By default, t.test assumes data is not paired. If the obs are paired, then
# specify paired = TRUE.
t.test(x, y, paired = TRUE)

# An example of paired data

# 1. Randomly select one group of people. Give them the SAT twice, once with
# morning coffee and once without. For each person, we will have two SAT scores.
# These are paired observations

# 2. Randomly select two groups of people. One group has a cup of morning coffee
# and takes the SAT. The other group just takes the test. We have a score for
# each person, but the scores are not paired in any way.

# Statistically, these experiments are quite different. In experiment 1, there
# are two observations for each person (caffeinated and decaf) and they are not
# statistically independent. In exp. 2, the data are independent.

# The p-value will be very different if you do t.test with paired / unpaired.
# Proceed with caution

#***************************************************************************
#** Chapter 9.16: Comparing the Locations of Two Samples Nonparametically **
#***************************************************************************

# You have samples from two populations. You don't know the distribution of the
# populations, but you know they have similar shapes. You want to know: Is one
# population shifted to the left or right compared to the other.

# You can use a nonparametric test, the Wilcoxon-Mann-Whitney ("WMW") test, 
# which is # implemented by the wilcox.test function. For paired observations 
# (every x_i is paired with y_i, set paired = TRUE.

wilcox.test(x, y, paired = TRUE)

# For unpaired observations, let paired default to FALSE
wilcox.test(x, y)

# Conventionally, a p-value of less than 0.05 indicates that the 2nd population
# is likely shifted to the left or right with respect to the first, whereas a p
# value of more than 0.05 provides no such evidence.

# When you stop making assumptions regarding the distributions of a population,
# you enter the world of nonparametric statistics. The WMW can be applied to
# more datasets that the t test, which requires that the data be normally
# distributed (for small samples). This test's only assumption is that the two
# populations have the same shape.

#***************************************************************************
#** Chapter 9.17: Testing a Correlation for Significance Nonparametically **
#***************************************************************************

# You calculated the correlation between two variables, but you don't know if 
# the correlation is statistically significant. 

# The cor.test can calc the p-value and the confidence interval of the
# correlation. If the variables came from normally distributed populations then
# use the default measure of correlation, which is the Pearson method.

cor.test(x, y)

# For non-normal populations, use the Spearman method instead
cor.test(x, y, method = 'Spearman')

# Conventionally, a p-value < 0.05 indicates that the correlation is likely
# significant whereas p > 0.05 indicates it is not.

#***************************************************************************
#*********** Chapter 9.18: Testing Groups for Equal Proportions ************
#***************************************************************************

# You have samples from two or more groups. The group's elements are
# binary-valued: either you have success or failure. You want to know if the
# groups have equal proportions of successes.

# In 9.11, we tested a proportion based on one sample. Here, we have samples
# from several groups and want to compare the proportions in the underlying
# groups.

# Example: I recently taught stats to 38 students and awarded an A to 14 of
# them. A colleague taught the same class and assigned an A to 10 of 40
# students. 
# Did I engage in grade inflation?

successes <- c(14, 10)
trials <- c(38, 40)
prop.test(successes, trials)

#         2-sample test for equality of proportions with continuity correction
# 
# data:  successes out of trials 
# X-squared = 0.7872, df = 1, p-value = 0.3749
# alternative hypothesis: two.sided 
# 95 percent confidence interval:
#  -0.1110245  0.3478666 
# sample estimates:
#    prop 1    prop 2 
# 0.3684211 0.2500000 

# The relatively large p-value means that we cannot reject the null hypothesis:
# the evidence does not suggest any difference between my grading and hers.

#***************************************************************************
#*** Chapter 9.19: Performing Pairwise Comparisons Between Group Means *****
#***************************************************************************

# You have several samples, and you want to perform a pairwise comparison 
# between the sample means. You want to compare the mean of every sample against
# the mean of every other sample.

# Place all the data into one vector and create a parallel factor to identify
# the groups. Use pairwise.t.test to perform the pairwise comparison of means.

pairwise.t.test(x, f) # x contains the data, f is the grouping factor

# Statistically speaking, pairwise comparisons are tricky. It is not the same as
# simply performing a t test on every possible pair. The p-values must be
# adjusted, for otherwise you get an overly optimistic result. Read the help
# pages on pairwise.t.test and p.adjust and a textbook to figure out the
# mechanics beneath this.

#***************************************************************************
#********* Chapter 9.20: Testing Two Samples for the Same Distribution *****
#***************************************************************************

# You have two samples, and you are wondering: Did they come from the same
# distribution?

# The Kolmogorov-Smirnov test compares two samples and tests them for being
# drawn from the same distribution. The ks.test function implements that test:

ks.test(x, y)

# The output includes a p-value. Conventionally, a p-value of less that 0.05
# indicates that the two samples (x and y) were drawn from different
# distributions whereas a p-value exceeding 0.05 provides no such evidence.

# The ks test is non-parametric, therefore you require no assumptions about the
# underlying distributions. Second, it checks the location, dispersion, and
# shape of the populations, based on the samples. If these characteristics
# disagree, the test will detect that, allowing one to conclude that the
# underlying distributions are different. 

# Suppose we assume that the vectors x and y come from differing distributions.
# Here, ks.test reports a p-value of 0.01297.

# From the small p-value, you can conclude the samples are from different
# distributions. 

