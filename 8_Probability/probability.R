#***************************************************************************
#***************************************************************************
#********************** Chapter 8: Probability *****************************
#***************************************************************************
#***************************************************************************

# Probability theory is the foundation of statistics, and R is the bombassshit 
# for probability.

Names of distributions
dnorm - normal density
pnorm - normal distribution function
qnorm - normal quantile function
rnorm - normal random variates

#***************************************************************************
#***************** Chapter 8.1: Counting the Number of Calculations ********
#***************************************************************************

choose(n, k) # merely counts the combinations

#***************************************************************************
#***************** Chapter 8.2: Generating the Combinations ****************
#***************************************************************************

combn(items, k) 

# generate all combinations of the numbers 1 through 5, taken three at a time
combn(1:5, 3)
combn(c('T1', 'T2', 'T3', 'T4', 'T5'), 3)

# good idea to check your number of combinations first before generating all of
# them

#***************************************************************************
#***************** Chapter 8.3: Generating Random Numbers ******************
#***************************************************************************

# The simple case of generating a uniform random number between 0 and 1 is handled
# by the runif function. This example generates one uniform random number
runif(1)
runif(10)

runif(1, min = -1, max = 3) # one uniform variate between -3 and 3
rnorm(1) # one standard normal variate
rnorm(1, mean = 100, sd = 15) # one normal variate, mean 100 and sd 15
rbinom(1, size = 10, prob = 0.5) # one binomal variate
rpois(1, lambda = 10) # One poisson variate
rexp(1, rate = 0.1) # one exponential variate
rgamma(1, shape = 2, rate = 0.1) # one gamma variate

# the following example generates three normal random values drawn from
# distributions with means of -10, 0, and +10, respectively (all distributions
# have a standard deviation of 1.0)
rnorm(3, mean = c(-10, 0, 10), sd = 1)

# this is a powerful capability in such cases as hierarchical models, where the
# parameters are themselves random

means <- rnorm(100, mean = 0, sd = 0.2)

#***************************************************************************
#********** Chapter 8.4: Generating Reproducible Random Numbers ************
#***************************************************************************

set.seed(666) # initialize the random number generator to a known state
runif(10) # generate 10 random numbers
set.seed(165) # Reinitialize to the same known state
runif(10) # Generate the same ten 'random' numbers

#***************************************************************************
#********** Chapter 8.5: Generating A Random Sample ************************
#***************************************************************************
# You want to sample a dataset randomly
# sample function will randomly select n items from a vector
sample(vec, n)
sample(world.series$year, 10)
# specify replace = TRUE to sample with replacement

# It's easy to implement a simple bootstrap using sampling with replacement. 
# This code fragment repeatedly samples a dataset X and calculates the sample 
# median

medians <- numeric(1000)
for (i in 1:1000){
    medians[i] <- median(sample(diamonds$x, replace = TRUE))
}
ci <- quantiles(medians, c(0.025, 0.975))
cat("95% confidence interval is (", ci, ")\n")

#***************************************************************************
#********** Chapter 8.6: Generating Random Sequences ***********************
#***************************************************************************
# You want to generate a random sequence, such as a series of simulated coin
# tosses or a simulated sequence of Bernoulli trials.

# Use the sample function. Sample from the set of possible values, and set 
# replace = TRUE
# the sample function randomly selects items from a set. It normally samples
# without replacement, which means that it will not select the same item twice. 
# With replace = TRUE, however, sample can select items over and over; this
# allows you to generate long random sequences of items.
sample(set, n, replace = TRUE)
sample(c('H', 'T'), 100, replace = TRUE)
sample(c(FALSE, TRUE), 20, replace = TRUE)

# Suppose we want to generate 20 Bernoulli trials with probability of success 
# p = 0.8
sample(c(FALSE, TRUE), 20, replace = TRUE, prob = c(0.2, 0.8))

# For the special case of a binary-valued sequence you can use rbinom, the 
# random  generator for binomal variates
rbinom(10, 1, 0.8)

#***************************************************************************
#********** Chapter 8.7: Randomly Permuting a Vector ***********************
#***************************************************************************
# You want to generate a random permutation of a vector
# If v is your vector(), then sample(v) returns a random permutation

# You can associate the sample function wiht sampling from large datasets.
# However, the default parameters enable you to create a random rearrangement of
# the dataset. The function call sample(v) is equivalent to:

sample(v, size = length(v), replace = FALSE)
sample(1:10) #[1]  6  8 10  4  2  3  9  5  7  1

#***************************************************************************
#**** Chapter 8.8: Calculating Probabilities for Discrete Distributions ****
#***************************************************************************
# You want to calculate either the simple or the cumulative probability 
# associated with a discrete random variable

# For a simple probability, P(X = x), use the density function. All built-in
# probability distributions have a density function show name is 'd' prefixed to
# the distribution function, for example dbinom for the binomial distribution

# For a cumulative probability, P(X <= x), use the distribution function. All
# built-in probability distributions have a distribution function whose name is
# 'p' prefixed to the distribution name; thus, pbinom is the distribution 
# function for the binomial distribution.
dbinom(7, size = 10, prob = .7)
# R calls dbinom the density function. Some textbooks call it the probability 
# mass function or the probability function. Calling it a density function 
# keeps the terminology consistent between discrete and continuous distributions

# The cumulative distribution function , P(X <= x) is given by the distribution
# function, which is sometimes called the cumulative probability function. The
# distribution function for the binomial distribution is pbinom. Here is the
# cumulative probability for x = 7 (ie P(X <= 7))
pbinom(7, size = 10, prob = 0.5)
pbinom(7, size = 10, prob = 0.7)

# Distribution Density Function: P(X = x) Distribution Function: P(X <= x)
# ------------ -------------------------- --------------------------------
# Binomial     dbinom(x, size, prob)      pbinom(x, size, prob)
# Geometric    dgeom(x, prob)             pgeom(x, prob)
# Poisson      dpois(x, lambda)           ppois(x, lambda)

# The complement of the cumulative probability is the survival function, 
# P(X > x).  
# All of the distribution functions let you find this right-tail probability
# simply by specifying lower.tail = FALSE
pbinom(7, size = 10, prob = 0.5, lower.tail = FALSE) 
# Thus we see that the probability of observing X > 7 is about 0.055

pbinom(8, size = 10, prob = 0.5, lower.tail = TRUE) + 
pbinom(8, size = 10, prob = 0.5, lower.tail = FALSE) 

The interval probability, P(x1 < x <= x2), is the probability of observing X
between the limits x1 and x2. It is simply calculated as the difference between
two cumulative probabilities : P(X <= x2) - P(X <= x1). 

# Here is P(3 < X <= 7) for our binomial value.
pbinom(7, size = 10, prob = 0.5) - pbinom(3, size = 10, prob = 0.5)

# R lets you specify multiple values of x for these functions and will return a
# vector of the corresponding probabilities. Here we calculate two cumulative
# probabilities, P(X <= 3) and P(X <= 7), in one call to pbinom.

pbinom(c(3, 7), size = 10, prob = 0.5)
# This leads to a one-liner for calculating interval probabilities. The diff
# function calculates the difference between successive elements of a vector. We
# apply it to the output of pbinom to obtain the difference in cumulative
# probabilities - in other words, the interval probability

diff(pbinom(c(3, 7), size = 10, prob = 0.5))

#***************************************************************************
#*** Chapter 8.9: Calculating Probabilities for Continuous Distributions ***
#***************************************************************************
# You want to calculate the distribution function (DF) or cumulative 
# distribution function (CDF) for a continuous random variable

# Use the distribution functon, which calcs P(X <= x). All built-in probability
# distributions have a distribution function whose name is 'p' prefixed to the
# distribution's abbreviated name - for instance, pnorm for the Normal
# distribution.

# The solution for this recipe is essentially identical to the solution for
# discrete random variables. The difference is that a continuous variable has no
# 'probability' as a single point P(X = x). Instead, they have a density at a
# point.

# Distriibution Distribution Function: P(X <= x)
# ------------- --------------------------------
# Normal        pnorm(x, mean, sd)
# Student's t   pt(x, df)
# Exponential   pexp(x, rate)
# Gamma         pgamma(x, shape, rate)
# Chi-Squared   pchisq(x, df)

# We can use the pnorm to calculate the probability that a man is shorter than 
# 66 # inches, assuming that men's heights are normally distributed with a mean 
# of 70 inches and a standard deviation of 3 inches. 

pnorm(66, mean = 70, sd = 3)

# likewise, we can use pexp to calculate the probability that an exponential
# variable with a mean of 40 could be less than 20
pexp(20, rate = 1 / 40)

# Just as for discrete probabilitiies, the functions for continuous probabilities
# use lower.tail = FALSE to specify the survival function, P(X > x). This call to
# pexp gives the probability that the same exponential variable could be greater
# than 50.
pexp(50, rate = 1/40, lower.tail = FALSE)

# P(20 < X < 50)
pexp(50, rate = 1/40) - pexp(40, rate = 1/40)

#***************************************************************************
#*** Chapter 8.10: Converting Probabilities to Quantiles *******************
#***************************************************************************

# Given a probability p and a distribution, you want to determine the
# corresponding quantile for p: the value x such taht P(X<=x) = p

# Every built in distribution includes a quantile function that converts
# probabilities to quantiles. THe function's name is 'q' prefixed to the
# distribution name; thus, for instance, qnorm is the quantile function for the
# Normal distribution.
qnorm(0.05, mean = 100, sd = 15)

# A common example of computing quantiles is when we compute the limits of a
# confidence interval. If we want to know they 95% confidence interval
# (alpha=0.05) of a standard normal variable, then we need the quantiles with
# probabilities of alpha/2 = 0.025 and (1 - alpha) / 2 = 0.975
qnorm(0.025)
qnorm(0.975)

#***************************************************************************
#************** Chapter 8.11: Plotting a Density Function Quantiles ********
#***************************************************************************

# You want to plot the density function of a probability distribution

# Define a vector x over the domain. Apply the distribution's density function 
# to x and then plot the result. This code snippet plots the standard normal
# distribution.

x <- seq(from = -3, to = +3, length.out = 100)
plot(x, dnorm(x))

# all the built-in probability distributions include a density function. for any
# density, the function name is d prepended to the density name. 

# The following code creates a 2x2 plot of four densities, as shown in figure 
# 8-1.

x <- seq(from = 0, to = 6, length.out = 100)
ylim <- c(0, 0.6)

par(mfrow = c(2, 2))
plot(x, dunif(x, min = 2, max = 4), main = 'Uniform', type = 'l', ylim = ylim)
plot(x, dnorm(x, mean = 3, sd = 1), main = 'Normal', type = 'l', ylim = ylim)
plot(x, dexp(x, rate = 1/2), main = 'Exponential', type = 'l', ylim = ylim)
plot(x, dgamma(x, shape = 2, rate = 1), main = 'Gamma', type = 'l', ylim = ylim)

# A raw density plot is rarely interesting by itself, and we usually shade a
# region of interest. Figure 8-2 shows a standard normal distribution with
# shading for the region 1<=z<=2.

# First, draw the density curve

x <- seq(from = -3, to = +3, length.out = 100)
y <- dnorm(x)
plot(x, y, main = 'Standard Normal Distribution', type = 'l', ylab = 'Density',
     xlab = 'Quantile')

# The body of the polygon follows the density curve where 1 <= z <= 2
region.x <- x[1<=x & x <=2]
region.y <- y[1<=x & x <=2]

# Add initial and final arguments, which drop down to the Y axis

region.x <- c(region.x[1], region.x, tail(region.x, 1))
region.y <- c(          0, region.y,                 0)

polygon(region.x, region.y, density = -1, col = 'red')
