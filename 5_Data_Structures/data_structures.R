#***************************************************************************
#***************************************************************************
#********************** Chapter 5: Data Structures *************************
#***************************************************************************
#***************************************************************************

#************************** Vectors ****************************************
# Vectors are homogenous
#     all elements must have the same type
# 
# Vectors can be indexed by position
#     so v[2] refers to the second element of v
# 
# Vectors can be indexed by multiple positions, returning a subvector
#     so v[c(2, 3)] is a subvector of v that consists of the 2nd and 3rd 
#     elements
# 
# Vectors elements can have names
#     Vectors have a names property, the same length as the vector itself, that
#     gives names to the element
v <- c(10, 20, 30)
names(v) <- c('Moe', 'Larry', 'Curly')
print(v)

# If a vector element has names, you can select them by name
v['Larry']

#************************** Lists *******************************************
# List are heterogenous
# List can contain elements of different types; in R lingo, list elements may 
# have different modes. Lists can even contain other structured objects, such 
# as lists and data frames; this allows you to create recusive data structures

# Lists can be indexed by position
# so lst[[2]] refers to the second element of lst. Note the double square
# brackets
#
# Lists let you extract sublists
# So lst[c(2, 3)] is a sublist of lst that consists of the second and third
# elements. Note the single square brackets
#
# List elements can have names
# Both lst[['Moe']] and lst$Moe refer to the element named 'Moe'

# since lists are heterogenous and since their elements can be retrieved by
# name, a list is like a dictionary or hash or lookup table in other programming
# languages. Unlike a dictionary in Python, a list in R can also be indexed by
# position

#************************** Mode: Physical Type *****************************
# In R, every object has a mode, which indicates how it is stored in memory: as
# a number, as a character string, as a list of pointers to other objects, as a
# function, and so forth

mode(3.1415) # numeric
mode(c(2.7182, 3.1415)) # numeric
mode('Moe') # character 
mode(list('Moe', 'Larry', 'Curly')) # list

#************************** Class: Abstract Type *****************************
# In R, every object has a class, which defines its abstract class.
# For example, a Data object consists of a single number
d <- as.Date('2010-03-15')
mode(d) # numeric
length(d) # 1
class(d) # Date
# R uses an object's class to decide how to process the object. For example, the
# generic function print has specialized versions (called methods) for printing
# objects according to their class: data.Frame, Date, lm, and so forth. When you
# print an object, R calls the appropriate print function according to the
# object's class

#***************************** Scalars ***************************************
# In some software, scalars and vectors are two different things. In R, they are
# the same thing: a scalar is simply a vector that contains exactly one 
# element. In R, scalar is just short hand for a one-element-vector

pi == pi[1] # TRUE
pi[2] # NA 

#**************************** Matrices ***************************************
# In R, a matrix is just a vector that has dimensions. It may seem strange at
# first, but you can transform a vector into a matrix simply by giving it
# dimensions.
# A vector has an attribute called dim, which is initially NULL, as shown here
A <- 1:6
dim(A) # NULL
dim(A)  <- c(2, 3) # vector reshaped into a 2x3 matrix

# A matrix can be created from a list too. Like a vector, a list has a dim
# attribute, which is initially NULL
B <- list(1,2,3,4,5,6)
mode(B) # list
class(B) # list

dim(B) # NULL
dim(B) <- c(2,3) 
mode(B) # list
class(B) # matrix

#***************************** Arrays ***************************************
# The discussion of matrices can be generalized to 3-dimensional or even
# n-dimensional structures: just assign more dimensions to the underlying vector
# (or list). The following example creates a 3-dimensional array with dimensions
# 2x3x2.
d <- 1:12
dim(d) <- c(2, 3, 2)
print(d)
mode(d) # numeric
class(d) # array

d <- 1:12
dim(d) <- c(2, 6)
print(d)
mode(d) # numeric
class(d) # matrix

# R prints one 'slice' of the structure at a time, since it's not (yet) possible
# to print a 3 dimensional structure on a 2-dimensional medium

# so, essentially a matrix is a vector in 2 dimensions, and an array is a vector
# in 3 or more dimensions

#***************************** Factors ***************************************
# A factor looks like a vector, but it has special properties. R keeps track of
# the unique values in a vector, and each unique value is called a level of the
# associated factor. R uses a compact representation for factors, which makes 
# them efficient for storage in data frames. In other programming languages, a 
# factor would be represented by a vector of enumerated values.

# There are two key uses for factors: 
# Categorical variables
# A factor can represent a categorical variable. Categorical variables are used
# in contingency tables, linear regression, analysis of variance (ANOVA),
# logistic regression, and many other areas.
# 
# Grouping
# This is a technique for labeling or tagging your data items according to their
# group. See the intro in Chapter 6

#***************************** Data Frames ***********************************
# Data frames are awesome. Most serious R applications involve data frames. A data
# frame is intended to mimic a dataset, such as one you might encounter in SAS or
# SPSS.
# 
# A data frame is tabular (rectangular) data structure, which means that it has
# rows and columns. It is not implemented by a matrix, however. Rather a data
# frame is a list:

# -The elements of the list are vectors
# -Those vectors and factors are the columns of the data frame
# -The vectors and factors must all have the same length; in other words, all
#  columns must have the same height
# -The equal-height columns give a rectangular shape to the data frame
# -The columns must have names

# Because a data frame is both a list and a rectangular structure, R provides 
# two different paradigms for accessing its contents
# 
# -You can use list operators to extract columns from a data frame, such 
# dfrm[i], dfrm[[i]], of dfrm$name.
# -You can use matrix-like notation, such as dfrm[i, j], dfrm[i, ], or dfrm[j, ]


#***************************************************************************
#********************** Chapter 5.1: Appending Data to a Vector ************
#***************************************************************************

v <- c(v, newItems)
# for a single item, you can assign the new item to the next vector element
v[length(v) + 1] <- newItem
v <- c(1, 2, 3)
v <- c(v, 4)
v

w <- c(5, 6, 7, 8)
v <- c(v, w)
v

v <- c(1, 2, 3)
v[10] <- 10
v # [1]  1  2  3 NA NA NA NA NA NA 10

#***************************************************************************
#********************** Chapter 5.2: Inserting Data into a Vector **********
#***************************************************************************

# Despite its name, the append fucntion inserts data into a vector by using the
# after parameter, which gives the insertion point for the new item or items

# The new items will be inserted at the position given by after. This example
# inserts 99 into the middle of the sequence.
append(1:10, 99, after=5) # [1]  1  2  3  4  5 99  6  7  8  9 10

# The special value of after=0 means insert the new items at the head of the
# vector
append(1:10, 99, after = 0)  #[1] 99  1  2  3  4  5  6  7  8  9 10

#***************************************************************************
#********************** Chapter 5.3: Understanding the Recycling Rule ******
#***************************************************************************

# When you do vector arithmetic in R, R perfroms element-by-element operations.
# That works well when both vectors have the same length: R pairs the elements 
# of the vectors and applies the operation to those pairs.
# 
# If the vectors have unequal lengths, it processes the vector elements in pair.
# Eventually the shorter vector is exhaused, so R will return to the beginning 
# of the shorter vector, recycling its elements, while continuing to take 
# elements from the longer vector. It will recycle the shorter elements vectors 
# as often as necessary until the operation is complete.

(1:6) + (1:3)
cbind(1:3, 1:6)
(1:6) + 10

#***************************************************************************
#*********** Chapter 5.4: Creating a Factor (Categorial Variable) **********
#***************************************************************************

# The factor function encodes your vector of discrete values into a factor
f <- factor(v) # v is vector of strings or integers
f <- factor(v, levels)

# Each possible value of a categorical variable is called a level. A vector of
# levels is called a factor. Factors fit very cleanly into the vector
# orientation of R, and they are used in a powerful ways for processing data and
# building stats models.

f <- factor(c('win', 'win', 'lose', 'tie', 'win', 'lose'))
wday <- c('sun', 'mon', 'tue', 'wed', 'thur', 'fri', 'sat')
my_data <- c('mon', 'mon', 'thur')

# Tell R explicitly what the different levels are in case there are no
# observations of a certain level
f <- factor(my_data, wday)

#***************************************************************************
#*** Chapter 5.5: Combining Multiple Vectors into One Vector and a Factor***
#***************************************************************************

# You have several groups of data, with one vector for each group. You want to
# combine the vectors into one large vector and simultaneously create a parallel
# factor that identifies each value's group

comb <- stack(list(v1 = v1, v2 = v2, v3 = v3)

#***************************************************************************
#********************* Chapter 5.6: Creating a List ************************
#***************************************************************************

lst <- list(x, y, z)
lst <- list(3.14, 'Moe', c(1, 1, 2, 3), mean)
 
# [[1]]
# [1] 3.14
# 
# [[2]]
# [1] "Moe"
# 
# [[3]]
# [1] 1 1 2 3
# 
# [[4]]
# function (x, ...) 
# UseMethod("mean")
# <environment: namespace:base>

# > lst[3]
# [[1]]
# [1] 1 1 2 3
# 
# > lst[[3]]
# [1] 1 1 2 3
# > class(lst[3])
# [1] "list"
# > class(lst[[3]])
# [1] "numeric"

lst <- list()
lst[[1]] <- 3.14
lst[[2]] <- 'Moe'

lst <- list(mid = 0.5, right = 0.841, far.right = 0.977)

#***************************************************************************
#********* Chapter 5.9: Building a Name/Value Association List *************
#***************************************************************************

# You want to create a list that associates names and values -- as would a
# dictionary, a hash, or lookup table in another language

# The list function lets you give names to elements, creating an association
# between each name and its value

lst <- list(mid = 0.5, right = 0.841, far.right = 0.977)
lst <- list()
lst$far.left <- 0.023
lst$left <- 0.159
lst$mid <- 0.500
lst$right <- 0.841
lst$far.right <- 0.977

values <- pnorm(-2:2)
names <- c('far.left', 'left', 'mid', 'right', 'far.right')
lst <- list()
lst[names] <- values

for (nm in names(lst)) cat('The', nm, 'limit is', lst[[nm]], '\n')

#***************************************************************************
#********* Chapter 5.10: Removing an Element from a List *******************
#***************************************************************************

# Assign NULL to the element. R will remove it from the list

lst[['far.left']] <- NULL

#***************************************************************************
#********* Chapter 5.11: Flatten a List into a Vector **********************
#***************************************************************************

# You want to flatten a List into a vector
# Basic stats functions work on vectors, not lists
lst <- list(seq(from=1, to=100, length.out=100))
mean(lst) # Error
mean(unlist(lst)) # Works

cat(lst, '\n') # Error
cat(unlist(lst), '\n') # Works

#***************************************************************************
#********* Chapter 5.12: Removing NULL Elements from a List ****************
#***************************************************************************

# Suppose a lst is list some of whose elements are NULL. This expression will
# remove the NULL elements

lst <- list('Moe', NULL, 'Curly')
lst[sapply(lst, is.null)] <- NULL

# 1. R calls sapply to apply the is.null function to evert element of the list
# 2. sapply returns a vector of logical values that are TRUE wherever the
# corresponding list element is NULL
# 3. R selects values from the list according to that vector
# 4. R assigns Null to the selected items, removing them from the list

#***************************************************************************
#********* Chapter 5.13: Removing List Elements Using a Condition **********
#***************************************************************************

# You want to remove elements from a list according to a conditional test, such 
# as removing elements that are negative or smaller than some threshold

lst[lst < 0] <- NULL
lst[lst == 0] <- NULL
lst[is.na(lst)] <- NULL

# The problem arises when you cannot easily build the logical vector. That often
# happens when you want to use a function that cannot handle a list. Suppose
# you want to remove list elements whose absolute value is less than 1. The abs
# function will not handle a list. 

lst <- list(-10:10)

lst[abs(lst) < 1] <- NULL

# The simplest solution is flattening the list into a vector by calling unlist 
# and then testing the vector
lst[abs(unlist(lst)) < 1] <- NULL
lst[lapply(lst, abs) < 1] <- NULL

# Lists can hold complex objects, too, not just atomic values. Suppose that mods
# is a list of linear models created by the lm function. The expression will
# remove any model whose R^2 value is less than 0.30:

mods[sapply(mods, function(m) summary(m)$r.squared < 0.3)] <- NULL

#***************************************************************************
#********* Chapter 5.14: Initializing a Matrix *****************************
#***************************************************************************

# Create a matrix and initialize it from given values
# Capture the data in a vector or list, and then use the matrix function to 
# shape the data into a matrix.

# thie example shapes a vector into a 2x3 matrix
matrix(vec, 2, 3)
theData <- c(1.1, 1.2, 2.1, 2.2, 3.1, 3.2)
mat <- matrix(theData, 2, 3)
mat

# Create an all-zeros matrix
matrix(0, 2, 3)
# Create a matrix populated with NA
matrix(NA, 2, 3)

mat <- matrix(c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3), 2, 3)

# A common idiom in R is typing the data itself in a rectangular shape that
# reveals the matrxi structure:
theData <- c(1.1, 1.2, 1.3, 
             2.1, 2.2, 2.3)
mat <- matrix(theData, 2, 3, byrow = TRUE)

mat <- matrix(c(1.1, 1.2, 1.3,
                2.1, 2.2, 2.3),
              2, 3, byrow = TRUE)

# Quick and dirty way to turn a vector into a matrix: just assign dimensions to
# the vector. The following example creates a vanilla vector and then shapes it
# into a 2x3 matrix:
v <- c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3)
dim(v) <- c(2, 3)

#***************************************************************************
#********* Chapter 5.15: Performing Matrix Operations **********************
#***************************************************************************

# transpose A
t(A)

# Matrix inverse of A
solve(A)

# Matrix multiplication of A and B
A %*% B

# An n-by-n diagonal (identity) matrix
diag(n)

# A*B is element-wise multiplication whereas A %*% B is matrix multiplication.
# All these functions return a matrix. Their arguments can be either matrices or
# data frames. If they are data frames then R will first convert them to
# matrices. 

#***************************************************************************
#** Chapter 5.16: Giving Descriptive Names to Rows and Columns of a Matrix *
#***************************************************************************

# You want to assign descriptive names to the rows and columns of a matrix
# Every matrix has a rownames attribute and colnames attribute. Assign a vector
# of character strings to the appropriate attribute

rownames(mat) <- c('rowname1', 'rowname2', 'rownamem')
colnames(mat) <- c('colname1', 'colname2', 'colnamem')
tech.corr <- c(1, 0.556, 0.390, 0.556, 1, 0.444, 0.390, 0.444, 1)
dim(tech.corr) <- c(3, 3)

colnames(tech.corr) <- c('IBM', 'MSFT', 'GOOG')
rownames(tech.corr) <- c('IBM', 'MSFT', 'GOOG')
print(tech.corr)

#***************************************************************************
#******** Chapter 5.17: Selecting One Row or Column from a Matrix **********
#***************************************************************************

# You want to select a single row or single column from a matrix 

vec <- mat[1, ]
vec <- mat[, 3]

# When you include the drop=FALSE argument, R retains the dimension.
row <- mat[1,, drop = FALSE]

#***************************************************************************
#******** Chapter 5.18: Initalizing a Data Frame from Column Data **********
#***************************************************************************
# Your data is organized by columns, and you want to assemble it into a data
# frame

# If data is captured in several vectors and/or factors, use the data.frame
# function to assemble them into a data frame
dfrm <- data.frame(v1, v2, v3, v4)
dfrm <- as.data.frame(list.of.vectors)
dfrm <- data.frame(pred1, pred2, pred3, pred4)
# data.frame takes the column names from your program variables. You can 
# override that default by supplying explicit column names
dfrm <- data.frame(p1 = pred1, p2 = pred2, p3 = pred3, r = resp)
lst <- list(p1 = pred1, p2 = pred2, p3 = pred3, r = resp)
as.data.frame(lst)

#***************************************************************************
#******** Chapter 5.19: Initalizing a Data Frame from Row Data *************
#***************************************************************************
# Your data is organized by rows, and you want to assemble it into a data frame
# Store each row in a one-row data frame. Store the one-row data frames in a 
# list. Use rbind and do.call to bind the rows into one, large data frame.

# here, obs is a list of one-row data frames
dfrm <- do.call(rbind, obs)

# Suppose you have a file with 10 rows and 4 columns. Load each row into a
# one-row dataframe, then combines those dataframes into a list called obs
rbind(obs[[1]], [[2]], ... ) # this doesn't work unless you explicitly state
# each observation

#instead do this
do.call(rbind, obs)

# for reasons beyond my control, data my be stored in lists rather one-row
# dataframes. You may be dealing wiht rows returned by a database package, for
# example. In that case, obs will be a list of lists, not a list of data frames.
# We first transform the rows into data frames using the Map function and then
# apply this recipe
dfrm <- do.call(rbind, Map(as.data.frame, obs))

#***************************************************************************
#*********** Chapter 5.20: Appending Rows to a Data Frame ******************
#***************************************************************************
# You want to append one or more new rows to a data frame
# Create a second, temporary data frame containing the new rows. The use the 
# rbind function to append the temporary data frame to the original data frame

newRow <- data.frame(city='West Dundee', county = 'Kane', state = 'IL', pop =
                     5428)
suburbs <- rbind(suburbs, newRow)
# use cbind to bind a column
# The new row must use the same column names as the data frame. Otherwise rbind
# will fail
# Dont use this to append many rows to a large data frame. That would force R to
# reallocate a large data structure repeatedly, which is a very slow process.
# Build the dataframe using 5.19 or 5.21 instead.

#***************************************************************************
#*********** Chapter 5.21: Preallocating a Data Frame **********************
#***************************************************************************
# You are building a data frame, row by row. You want to preallocate the space
# instead of appending rows incrementally.

# Here n is the number of rows needed for the data frame
dfrm <- data.frame(colname1 = numeric(n), colname2=character(n), ... etc ...)

# Suppose you want to create a data frame with 1,000,000 rows and three columns:
# two numeric and one character. Use the numeric and character functions to
# preallocate the columns; then join them together using data.frame:

N <- 1000000
dfrm <- data.frame(dosage = numeric(N), lab = character(N), response =
                   numeric(N))

# Now I have a dataframe with the correct dimensions, 1000000x3, waiting to
# recieve its contents
# Data frames can contain factors, but preallocating a factor is a little 
# trickier. You can't simply call factor(n). You need to specify the factors
# levels because you are creating it. Continuing the example, suppose you want
# the lab column to be a factor, not a character string, and that the possible
# levels are NJ, IL, and CA. Include the levels in the column specification,
# like this:
N <- 1000000
dfrm <- data.frame(dosage = numeric(N), 
                   lab = factor(N, levels = c('NJ', 'IL', 'CA')),
                   response = numeric(N))

#***************************************************************************
#*********** Chapter 5.22: Selecting Data Frames Columns by Position *******
#***************************************************************************
# You want to select columns from a data frame according to their position

# To select a single column, use the list operator
dfrm[[n]] # returns the nth column of dfrm

# To select one or more columns and package them in a data frame, use the
# following sublist expressions
dfrm[n] # returns a dataframe consisting solely of the nth column of dfrm
dfrm[c(n1, n2, ..., nk)] # returns a dataframe built from the columns in
# position n1, n2, ..., nk of dfrm

dfrm[, n] # returns the nth column (assuming n contains exactly one value)
dfrm[, c(n1, n2, ..., nk)] # returns a data frame built from the columns in
# positions n1, n2, ..., nk

# Matrix style subscripting can return two different data types (either column 
# data frames) depending upon whether you select one column or multiple columns

#***************************************************************************
#*********** Chapter 5.23: Selecting Data Frame Columns by Name ************
#***************************************************************************
# You want to select columns from a data frame according to name 
dfrm[['name']] # returns one column, the column called name
dfrm$name # same as previous, just different syntax
dfrm['name'] # selects one column and packages it inside a data frame object
dfrm[c('name1', 'name2',...'namek')] # selects several columns and packages them
# in a data frame

# You can use matrix-style subscripting to select one or more columns
dfrm[, 'name']
dfrm[, c('name1', 'name2', ..., 'namek')] # selects several columns and packages
# in a data frame

#***************************************************************************
#*********** Chapter 5.24: Selecting Rows and Columns More Easily **********
#***************************************************************************
# You want an easier way to select rows and columns from a data frame or matrix
# Use the subset function. Note that you do not quote the column names
subset(dfrm, select=colname)
subset(dfrm, select=c(colname, colname2,..., colnamek))

# The subset argument is a logical expression that selects rows. Inside the
# expression, you can refer to the column names as part of the logical
# expression. In this example, response is a column in the data frame, and we
# are selecting rows with a positive response
subset(dfrm, subset = (response > 0))

# subset is very useful when you combine the select and subset arguments
subset(dfrm, select = c(predictor, response), subset=(response > 0))

# Indexing is the official way to select rows and columns from a dataframe,
# as described in 5.23 and 5.22. however, indexing is cumbersome when the index
# expressions become complicated.
# The subset function provides a more convenient and readable way to select rows
# and columns. It's beauty is that you can refer to the columns of the data 
# frame right inside the expression for selecting columns and rows
require(MASS)
data(Cars93)
subset(Cars93, select = RPM, subset=(MPG.city > 30))
subset(Cars93, select = c(MPG.city, Cylinders),  subset=(MPG.city < 18))
subset(Cars93, select = c(Model, Min.Price, Max.Price), subset = (Cylinders ==
                      4 & Origin == "USA"))

subset(Cars93, select = c(Manufacturer, Model), subset = c(MPG.highway >
                                                           median(MPG.highway)))

#***************************************************************************
#*********** Chapter 5.25: Changing the Names of Data Frame Columns ********
#***************************************************************************
# You converted a matrix or list into a data frame. R gave names to the columns,
# but the names are at best uninformative and at worst bizarre.
# Dataframes have a colnames attribute that is a vector of column names. You can
# update individual names fo the entire vector. 
colnames(dfrm) <- new_names # newnames is a vector of character strings

#***************************************************************************
#************** Chapter 5.26: Editing a Data Frame  Data Frame Columns *****
#***************************************************************************
# Data in a data frame are incorrect or missing. You want a convenient way to 
# edit data frame contents
# R includes a data editor that displays your data frame in a spreadsheet-like
# window. Invoke the editor using the edit function.

temp <- edit(dfrm) # only use this for emergency touch-ups
dfrm <- temp # overwrite only if you're happy with the changes

temp <- edit(diamonds)

#***************************************************************************
#************** Chapter 5.27: Removing NAs from a Data Frame ***************
#***************************************************************************
# Your data frame contians NA values, which is creating problems for you
# use na.omit to remove rows that contain any NA values
# Be careful about dropping data. na.omit will remove entire rows
na.omit(dfrm)

#***************************************************************************
#************** Chapter 5.28: Excluding Columns by Name ********************
#***************************************************************************
# You want to exclude a column from a dataframe using its name
# Use the subset function with a negated argument for the select parameter
subset(dfrm, select = -badboy) # All columns except badboy
cor(subset(patient.data, select = -patient.id))
cor(subset(patient.data, select = c(-patient.id, -dosage)))

#***************************************************************************
#************** Chapter 5.29: Combining Two Data Frames ********************
#***************************************************************************
# You want to combine the contents of two data frames into one data frame
# Combine the columns
all.cols <- cbind(dfrm1, dfrm2) # if one dataframe is short, will use recycling
# Combine the rows
all.rows <- rbind(dfrm1, dfrm2) # must have same width and same column names,
# while the order of the columns doesn't matter

# The merge function can combine data frames that are otherwise incompatible 
# owing to missing or different columns. 
# Also see plyr and reshape2 for more options on slicing, dicing, and 
# recombining data frames

#***************************************************************************
#************** Chapter 5.30: Merging Data Frames by Common Column *********
#***************************************************************************
# You have two data frames that share a common column. You want to merge their
# rows into one data frame by matching on the common column 

# Use the merge function to join the data frames into one new data frame based
# on the common column.
m <- merge(df1, df2, by = 'name') # here name is the column common to both 
# in SQL terms, the merge function essentially performs a join operation on the
# two data frames. It has many options for controlling that join operation, all
# of which are described on the help page for merge.
# See also recipe 5.29 for other ways to combine data frames

#***************************************************************************
#************** Chapter 5.31: Accessing Data Frame Contents More Easily ****
#***************************************************************************
# Your data is stored in a data frame. You are getting tired or repeatedly
# typing the data frame name and want to access the columns more easily

# For quick, one-off expressions, use the with function to expose the column
# names
# Inside expr, you can refer to columns of dataframe by their names - as if they
# were simple variables
with(dataframe, expr)
# For repetitive access, use the attach function to insert the data frame into
# your serach list. You can then refer to the data frame columns by name without
# mentioning the data frame
attach(dataframe) # after the attach, the second item in the search list is
# dataframe. Confirm with search()
detach() # when donw. confirm with search()

#***************************************************************************
#************** Chapter 5.32: Converting One Atomic Value into Another *****
#***************************************************************************
# You have data which has an atomic data type: character, complex, double,
# integer or logical. You want to convert this value into of another atomic data
# type 

as.character(x)
as.complex(x)
as.numeric(x) or as.double(x)
as.integer(x)
as.logical(x)

#***************************************************************************
#******* Chapter 5.33: Converting One Strucruted Data Type Into Another ****
#***************************************************************************
# You want to convert a variable from one structured data type to another - for
# example, converting a vector into a list or a matrix into a data frame

as.data.frame(x)
as.list(x)
as.matrix(x)
as.vector(x)
