#***************************************************************************
#***************************************************************************
#********************** Chapter 2: Some Basics******************************
#***************************************************************************
#***************************************************************************

#***************************************************************************
#********************** 2.1 Print Something ********************************
#***************************************************************************

# provide a sequence and its desired shape
print(matrix(c(1,2,3,4), 4, 5))

# is an error
print('The zero occurs at', 2 * pi, 'radians')

# have to do a cat to print many objects
cat('The zero occurs at', 2 * pi, 'radians', '\n')

fib <- c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)

# cat can print simple vectors, but not matrices or lists
cat('The first few fibonnaci numbers are:', fib, '...\n')

#***************************************************************************
#********************** 2.3 Listing Variables *****************************
#***************************************************************************

x <- 10
y <- 50
z <- c('three', 'blind', 'mice')
f <- function(n, p) sqrt(p * (1 - p) / n)

# list names of variables in workspace
ls()

# list name and description of variables in workspace
ls.str()

.hidvar  <- 10
# set all.names to TRUE to see hidden variables, which start with .
ls(all.names = TRUE)

#***************************************************************************
#********************** 2.4 Deleting Variables *****************************
#***************************************************************************

x <- 2 * pi
x
# To remove object from workspace
rm(x)
rm(x, y, z)
# dont put this in shared code
rm(list=ls())

#***************************************************************************
#********************** 2.5 Creating a Vector ******************************
#***************************************************************************

# A vector can contain a either numbers, strings, or logical values but not 
# a mixture 

c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
c(1*pi, 2*pi, 3*pi, 4*pi)
c('Everyone', 'loves', 'stats.')
c(TRUE, TRUE, FALSE, TRUE)

# If one of the arguments to c(...) is a vector, c will flatten it out and
# combine it with the other vectors

v1 <- c(1, 2, 3)
v2 <- c(4, 5, 6)
c(v1, v2)

# Two data elements can coexist in a vector only if they have the same mode
# The modes of 3.1415 and 'foo' are numeric and character, respectively

mode(3.1415)
mode('foo')

# To make a vector from them, R converts 3.1415 to character mode
c(3.1414, 'foo')
mode(c(3.1414, 'foo')) # >"character"

#***************************************************************************
#********************** 2.6 Computing Basic Statistics *********************
#***************************************************************************

x <- c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
mean(x)
median(x)
sd(x) # sample standard deviation
var(x) # sample variance

# correlation and covariance
x <- c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
y <- log(x+1)
cor(x, y)
cov(x, y)

# All these functions are picky about NA
x <- c(0, 1, 1, 2, 3, NA)
mean(x)
sd(x)

# Can do basic statistics with dataframes too
data(iris)
print(iris)
mean(iris)
sd(iris)

# var acts as covariance when run on a dataframe
var(iris)

# Drop Factor from dataframe so it'll stop barfing on cor and cov
drop <- 'Species'
df <- iris[,  !names(iris) %in% drop]        
var(df)
cor(df)
cov(df)

#***************************************************************************
#********************** 2.7 Creating Sequences *****************************
#***************************************************************************

1:5
# increments other than 1
seq(from=1, to=5, by=2)
# create a series of repeated values
rep(1, times=5)

0:9
10:19
9:0
seq(from=0, to=20)
seq(from=0, to=20, by=2)
seq(from=0, to=20, by=5)

# specify length for the output sequence
seq(from=0, to=20, length.out=5)
seq(from=0, to=20, length.out=5)
seq(from=1.0, to=2.0, length.out=5)
# repeated value
rep(pi, times=5)

#***************************************************************************
#********************** 2.8 Comparing Vectors ******************************
#***************************************************************************

# Compare two vectors or you want to compare an entire vector against a scalar
a <- 3
a == pi
a != pi
a < pi
a > pi
a <= pi
a >= pi

v <- c(3, pi, 4)
w <- c(pi, pi, pi)
v == w
v != w
v < w
v <= w
v > w
v >= w
v == pi
v != pi
v <- c(3, pi, 4)
all(v == 0)
any(v == pi)

#***************************************************************************
#********************** 2.9 Selecting Vector Elements **********************
#***************************************************************************

# you want to extract one or more elements from a vector

fib <- c(0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
# first element has index of 1!!!
fib[1]
fib[2]
fib[1:3]
fib[4:9]
fib[c(1, 2, 4, 8)]

# exclude a value, eg exclude the first value and return all other values
fib[-1]
fib[1:3]

# exclude first three objects
fib[-(1:3)]
fib < 10 # This vector is TRUE wherever fib is less than 10
fib[fib < 10] # use the vector to select elements less than 10

fib %% 2 == 0
fib[fib %% 2 == 0]

# *************** stats and distribution fun **********************************
# Select all elements greater than the median
v <- rnorm(100, mean=0, sd=0.4)
v[v > median(v)]

# Select all elements in the lower and upper 5%
v[(v < quantile(v, 0.05)) | (v > quantile(v, 0.95))]
v < quantile(v, 0.05) | v > quantile(v, 0.95)

# Select all elements that exceed +-2 standard deviations from the mean
v[abs(v-mean(v)) > 2*sd(v)]
which(abs(v-mean(v)) > 2*sd(v))

# Select all elements that are neither NA nor NULL
v[!is.na(v) & !is.null(v)]

# ****************************************************************************
years <- c(1960, 1964, 1976, 1994)
names(years) <- c('Kennedy', 'Johnson', 'Carter', 'Clinton')
years

# index by name
years["Carter"]
years["Clinton"]
years[c("Carter", "Clinton")]


#***************************************************************************
#********************** 2.10 Performing Vector Arithmetic ******************
#***************************************************************************

# vector operations that require looping in other languages are one-liners in R
# Most vectorized operations are implemented in C, so much faster than the code 
# I'd write in R or Python (but maybe not numpy)

# You want to operate on an entire vector at once
v <- 11:15
w <- 1:5
v + w
v - w
v * w
v / w
w ^ v

# recenter an entire vector in one expression simply by subtracting the mean of
# its contents
w
mean(w)
w - mean(w)
sd(w)

# calc zscore
(w - mean(w)) / sd(w)
sqrt(w)
log(w)
sin(w)

#***************************************************************************
#********************** 2.11 Getting Operator Precedence Right *************
#***************************************************************************

n <- 0
# R thinks this is (0:n)-1
0:n-1

#***************************************************************************
#********************** 2.12 Defining a Function ***************************
#***************************************************************************

# R does not have a built-in function for calculating the coefficient of
# variation. You can define the calculation in this way
cv(1:10)

#this list has a length of one
lst <- list(1:10)
cv <- function(x) sd(x)/mean(x)

# returns a list of the same length as x, each element of which is the result of
# applying FUN to the correspoding element of xx
lapply(lst, cv)

gcd <- function(a, b) {
    if (b == 0) return(a)
    else return(gcd(b, a %% b))
}

# R allows for one anonymous functions which are good for one-liners
lapply(lst, function(x) sd(x)/mean(x))

# ****************************** Function Primer ***************************

# Return value
# all functions return a value. Normally a function returns the value of the
# last expression in its body. You can also use return(expr)

# Call by value
# Function parameters are call by value - in other words, if you change a
# parameter then the change is local and does not affect the caller's value

# Local variables
# You create a local variable simply by assigning a value to it. When the
# function exits, local variables are lost

# Conditional execution
# The R Syntax includes an if statement. See help(control) for details.

# Loops
# The R syntax also includes for loops, while loops, and repeat loops. 

# Global Variables
# Within a function you can change a global variable by using the <<- assignment
# operator, but this is not encouraged

#***************************************************************************
#********************** 2.14 Avoiding Some Common Mistakes *****************
#***************************************************************************

# Forgetting the parentheses after a function invocation

# Forgetting to double up backslashes in Windows files path

# Incorrectly continuing an expression across lines

# Using = instead of ==

# writing 1:n+1 when you mean 1:(n+1)

# Getting bitten by the recycling rule. Vector arithmetic and comparisons work
# well when both vectors have the same length. However the results can be
# baffling when the operands are vectors of different lengths. See Recipe 5.3

# Installing a package but not loading it with require('package') or
# libary('package')

# Writing aList[i] when you mean aList[[i]] or vice versa
# If the variable lst contains a list, it can be indexed in two ways: lst[[n]]
# is the nth element of the list; whereas lst[n] is a list whose only element is
# the nth element of lst. That's a big difference. See Recipe 5.7
l <- list(1:10)
class(l[1]) # "list"
class(l[[1]]) # "integer"

# Using & instead of &&, | for ||, and vice versa
# Use & and | in logical expressions involving the logical values TRUE and
# FALSE.
# Use && and || for the flow-of-control expressions inside if and while
# statements
# && and || give peculiar results when applied to vectors of logical values

# Passing multiple arguments to a single argument function
# The value of mean(9, 10 , 11)? It's 9, not 10. 
# The mean function computes the mean of the first argument
# Other arguments like mean, take one argument. Coder Beware.

# Thinking that max behaves like pmax, or that min behaves like pmin
# The max and min function have mulitple arguments and return one value: the
# maximum or minimum of all their arguments.
# The pmax and pmin functions have multiple arguments but return a vector with
# values taken element-wise from the arguments. See Recipe 12.9

# Misusing a function that does not understand data frames
# Some functions like mean and sd handle dataframes well. Others dont. This
# includes max, min, and median. They'll lump every value together across the
# dataframe and then return a value 

# Posting a question to StackOverflow or the mailing list before searching for
# the answer. Sure.
