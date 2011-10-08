#***************************************************************************
#***************************************************************************
#************** Chapter 11: Linear Regression and Some Basics **************
#***************************************************************************
#***************************************************************************

#***************************************************************************
#**************************** Introduction**********************************
#***************************************************************************

# In stats, models is where we make our money. Models quantify the relationships
# between our variables.

# The Good: It's really easy to create linear regressions with R.
# The Bad: It's really easy to create linear regression with R

# To stay away from evil, ask:

# 1. Is the model statistically significant?
# Check the F statistic at the bottom of the summary

# 2. Are the coefficients significant?
# Check the coefficient's t statistic and p-values in the summary, or check
# their confidence intervals.

# 3. Is the model useful?
# Check the R^2 near the bottom of the summary

# 4. Does the model fit the data well?
# Plot the residuals and check the regression diagnostics

# 5. Does the data satisfy the assumptions behind linear regression?
# Check whether the diagnostics confirm that a linear model is reasonable for
# your data.

# ****************************** ANOVA ***************************************
# Analsis of Variance is a powerful stats technique. First year grad students
# are taught ANOVA immediately because of its importance, both theoretical and
# practical. 

# Regression creates a model, and ANOVA is a method of evaluating such models.
# The mathematics of ANOVA are intertwined with the math of regression, so
# statisticians usually present them together.

# ANOVA is a family of techniques that are connected by a common mathematic
# analysis. This chapter mentions several applications. 

# One-way ANOVA:
# This is the simplest application of ANOVA. Suppose you have data samples from
# several populations and are wondering whether the populations have different
# means. One-way ANOVA answers that. If the populations have normal
# distributions, use the oneway.test function; otherwise use the nonparametric
# version, the kruskal.test function.

# Model Comparison:
# When you add or delete a predictor variable from a linear regression, you want
# to know whether the change did or did not improve the model. The anova
# function compares two regression models and reports whether they are
# significantly different.

# ANOVA Table
# The anova function can also construct the ANOVA table of a linear regression
# model, which includes the F statistic needed to gauge the model's statistical
# significance. This important table is discussed in nearly every textbook on
# regression.

# The authors favorite text on linear regressions is 'Applied Linear Regression
# Models' by Kutner, Nachtstein, and Neter. 

# He also likes Practical Regression and ANOVA using R by Julian Faraway because
# it illustrates regression using R and is quite readable. And you can get it
# for free at CRAN. 

#***************************************************************************
#********************* 11.1 Performing Simple Linear Regression ************
#***************************************************************************

# You have two vectors x and y that hold paired observations (x1, y1), (x2,
# y2)... You believe there is a linear relationship between x and y, and you
# want to create a regression model of the relationship.

# The lm function performs a linear regression and reports the coefficients
lm(y ~ x)

# Simple linear regression involves two variables, a predictor variable - often
# called x, and a response variable, often called y. The regression uses the
# ordinary least-squares (OLS) algo to fit the linear model.

# Where beta_0 and beta_1 are the regression coefficients and e_i are the error
# terms.

# The lm function can perform linear regression. The main argument is a model
# formula, such as y ~ x. The formula has the response variable on the left of
# the tilde character and the predictor variable on the right. The function
# estimates the regression coefficients, beta_0 and beta_1, and reports them as
# the intercept and the coefficient of x, respectively.

# The lm function lets you specify a data frame by using the data parameter. If
# you do, the function will take the variables from the data frame and not from
# your workspace.

lm(y ~ x, data = dfrm)

#***************************************************************************
#****************** 11.2 Performing Multiple Linear Regression *************
#***************************************************************************

# You have several predictor variables (eg: u, v, w) and a response variable y.
# You believe there is a linear relationship between the predictors and the
# response, and you want to perform a linear regression on the data.

# Use the lm function. Specify the multiple predictors on the right hand side of
# the formula, separated by the plus signs (+):
lm(y ~ u + v + w)

# Multiple linear regression is the obvious generalization of simple linear
# regression. It allows multiple predictor variables instead of one predictor
# variable and still uses OLS to compute the coefficients of a linear
# equation. The three-variable regression just given corresponds to this linear
# model.

# y_i = b_0 + (b_1 * u_i) + (b_2 * v_i) + (b_3 * w_i) + e_i
lm(y ~ u + v + w)

y <- rnorm(100)
u <- seq(1, 100)
v <- rgamma(100, 1)
w <- rbinom(100, 10, 0.5)
dfrm <- data.frame(y, u, v, w)

lm(y ~ u + v + w, data = dfrm)

#***************************************************************************
#********************* 11.3 Getting Regression Statistics ******************
#***************************************************************************

# You want the critical statistics and information regarding your regression,
# such as R^2, the F statistic, confidence intervals for the coefficients,
# residuals, the ANOVA table, and so forth.

# Save the regression model in a variable, say m:
m <- lm(y ~ u + v + w)
anova(m)
coefficients(m)
confint(m)
deviance(m)
effects(m)
fitted(m)
residuals(m)
resid(m)
summary(m)
vcov(m)
summary(m)

#***************************************************************************
#********************* 11.4 Understanding the Regression Summary ***********
#***************************************************************************

# You created a linear regression model, m. However, you are confused by the
# output from summary(m)

# The model summary is important because it links you to the most critical
# regression statistics. Here is the model summary from Recipe 11.3

summary(m)
# Call:
# lm(formula = y ~ u + v + w)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -2.0952 -0.7409 -0.1081  0.6181  2.5900 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)
# (Intercept)  0.094688   0.363751   0.260    0.795
# u           -0.003519   0.003474  -1.013    0.314
# v           -0.066783   0.113146  -0.590    0.556
# w            0.047859   0.063227   0.757    0.451
# 
# Residual standard error: 0.9991 on 96 degrees of freedom
# Multiple R-squared: 0.01786,    Adjusted R-squared: -0.01283 
# F-statistic: 0.5821 on 3 and 96 DF,  p-value: 0.6282 
# summary(m)

# Ideally, the regression residuals would have a perfect, normal distribution.
# These stats help you identify possible deviations from normality. The OLS algo
# is mathetmatically guaranteed to produce residuals with a mean of zero. Hence
# the sign of the median indicates the skew's direction, and the magnitude of
# the median indicates the extent. In this case, the median is negative which
# suggests a skew to the left. 

# The Min and Max residuals offer a quick way to detect extreme outliers in the
# data, since extreme outliers (in the response variable) produce large
# residuals. 

# ***************************** Coefficients *********************************

# The column labeled Estimate contains the estimated regression coefficients as
# calculated bya the OLS.

# Theoretically, if a variables coefficients are zero then the variable adds
# nothing to the model. Yet the coeffs are only estimates, and will never be
# exactly zero. 

# Statistically speaking, how likely is it that the coefficient is zero? That is
# the purpose of the t statistics and the p-values, which in the summary are
# labeled 't value' and 'Pr(>|t|)'

# The p-value is a probability. It gauges the likelihood that the coefficient is
# not signifiant, so smaller is better. Big is bad because it indicates a high
# likelihood of insignificance. In this example, the p-value for the u
# coefficient is .314, so u is likely insignificant. Variables with large p
# values are candidates for elimination. 

# A handy feature of R is that it flags the significant variables for quick id. 

# *** p-value between 0 and 0.001
# **  p-value between 0.001 and 0.01
# *   p-value between 0.01 and 0.05
# .   p-value between 0.05 and 0.1
# (blank) p-value between 0.1 and 1.0

# The column Std. Error is the standard error of the estimated coefficient. The
# column labeled t value is the t statistic from which the p-value was
# calculated. 

# ************************ Residual standard error ***************************

# This reports the standard error of the residuals (sigma) -- that is, the
# sample standard deviation of e

# R^2 (coefficient of determination)

# R^2 is a measure of the model's quality. Bigger is better. Mathematically, it
# is the fraction of the variance of y that is explained by the regression
# model. The remaining variance is the not explained by the model, so it must be
# due to other factors (ie unknown variables or sampling variability). In this
# case, the model explains very little of what's happening.

# That being said, the author strongly suggests using the adjusted rather than
# the basic R^2. The adjusted value accounts for the number of variables in your
# model and so is a more realistic assessment of it effectiveness. 

# ******************************* F Statistic ********************************
# The F statistic tells you whether the model is significant or insignicant. The
# model is significant if any of the coefficients are nonzero ( ie if B_i <> 0
# for some i). It is insignificant if all coeffs are zero (B_1 = B_2 ...B_n = 0)

# Conventionally, a p-value of less than 0.05 indicates that the model is likely
# significant, whereas a value of greater than 0.05 indicate that the model is
# likely not significant. 

# Most people look at the R^2 stat first. The statistician starts with the F
# stat, for if the model is not significant nothing else matters.

#***************************************************************************
#************ 11.5 Performing Linear Regression Without an Intercept *******
#***************************************************************************
# You want to perform a linear regression, but you want to force the intercept
# to be zero.

# Add '+0' to the righthand side of your regression formula. That will force lm
# to fit the model with a zero intercept. 

lm(y ~ x + 0)

# The corresponding regression equaiton is:
# y_i = B_x_i + e_i

# The author strongly suggests you check that modeling assumption before
# proceeding. Perform a regression with an intercept; then see if the intercept
# could plausibly be zero. Check the intercept's confidence interval. 
# If the Intercept CI contains 0, then go ahead and to do the model without an
# intercept

#***************************************************************************
#********* 11.6 Performing Linear Regression with Interaction Terms ********
#***************************************************************************
# You want to include an interaction term in your regression

# The R syntax for regression formulas lets you specify interaction terms. The
# interaction of two variables, u and v, is indicated by separating their names
# with an asterik(*)
lm(y ~ u*v)

# This corresponds to the model y_i = B0 + (B1 UI) + (B2 VI) + (B3 UI VI) + EI
# which includes the first-order interaction term (B3 UI VI)

# In regression, an interaction occurs when the product of two predictor
# variables is also a significant predictor (ie, in addition to the predictor
# variables themselves). 
# Suppose we have two predictors, u and v, and want to include their interaction
# in the regression. This is expressed by the following equation:
yi = B0 + B1Ui + B2Vi + B3UiVi + Ei

# Here the product term, B3UiVi is called the interaction term. The R formula
# for that equation is
y ~ u*v

# When you write y~u*v, R auto includes u and v, and their product in the model.
# This is for a good reason. If a model includes an interaction term, such as
# B3UiVi, then regression theory tells us the model should also contain the
# constituent variables Ui, and Vi. 

#***************************************************************************
#******* 11.12 Finding the Best Power Transformation (Box-Cox Procedure ****
#***************************************************************************

# You want to improve your linear model by applying a power transformation to
# the response variable

# Use the Box-Cox procedure, which is implemented by the boxcox function of the
# MASS package. The procedure will identify a power, a lambda, such transforming
# y into y^lambda will improve the fit of your model

library(MASS)
m <- lm(y ~ x)
boxcox(m)

# To illustrate the Box-Cox transformation, let's create some artificial data
# using the equation y^(-1.5) = x + e, where e is the error term:

x <- 10:100
eps <- rnorm(length(x), sd = 5)
y <- (x + eps)^(-1 / 1.5)

# Now we (mistakenly) model the data using a simple linear regression and derive
# and adjusted R^2 of 0.6935:

m <- lm(y ~ x)
summary(m)

# When plotting the the residuals against the fitted values, we get a clue that
# something is wrong:

plot(m, which = 1)

# This plot has a parabolic shape, which is a clue that something aint right. A
# possible fix is a power transformation on y, so we run the Box-Cox procedure:
require(MASS)
bc <- boxcox(m)

# The boxcox function creates a plot, that plots values of lambda against the
# log-likelihood of the resulting model. We want to maximize that
# log-likelihood, so the function draws a line at the best value and also draws
# lines at the limits of its confidence interval. In this case, it looks like
# the best value is around -1.5, with a confidence interval of about 
# (-1.75, -1.25)

# oddly , the boxcox function does not return the best value of lambda. Rather,
# it returns the (x, y) pairs displayed in the plot. It's pretty easy to find
# the values of lambda that yeild the largest log-likelihood y. We use the
# which.max function:

which.max(bc$y)

# Then this gives us the position of the corresponding lambda:
lambda <- bc$x[which.max(bc$y)]
lambda

# The function reports that the best lambda is -1.47 (will change depending on
# rnorm). In an actual application, the author would urge you to interpret this
# number and choose the power that makes sense to you - rather than blindly
# accepting this 'best' value. Use the graph to assist you in that
# interpretation. Here, let's go with 1.47

# We can apply the power transform to y and then fit the revised model; this
# gives a much better R^2 of 
z <- y^lambda
m2 <- lm(z ~ x)
summary(m)
summary(m2)

# Or if you're a one-liner kind of dude, do:
m2 <- lm(I(y^lambda) ~ x)

# By default, boxcox searches for values of lambda in the range -2 to +2. You
# can change that via the lambda argument; see the help page for details.

# The author suggests viewing the Box-Cox result as a starting point, not as a
# definitive answer. If the confidence interval for lambda includes 1.0, it may
# be that no power transformation is actually helpful. As always, inspect the
# residuals before and after the transformation. Did the really improve?
par(mfrow = c(1, 2))
plot(m, which = 1)
plot(m2, which = 1)

#***************************************************************************
#******* 11.13 Forming Confidence Intervals for Regression Coefficients ****
#***************************************************************************

# You are performing linear regression and you need the confidence intervals for
# the regression coefficients.

# Save the regression model in an object; then use the confint function to
# extract confidence intervals

# The Solution
m <- lm(y ~ x1 + x2)
confint(m)

# The Solution uses the model y = b0 + b1x1i + b2x2i + ei. The confint function
# returns the confidence intervals for the intercept b0, the coefficient x1b1,
# and the coefficient of x2b2:
con
