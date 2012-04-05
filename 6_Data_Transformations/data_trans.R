#***************************************************************************
#***************************************************************************
#********************** Chapter 6: Data Transformations ********************
#***************************************************************************
#***************************************************************************

# This chapter is all about the apply functions: apply, lapply, sapply, tapply,
# mapplym and their cousins: by and split

#*                6.1 Definining Groups Via a Factor                       *
An important idiom in R is using a factor to define a group. Suppose we have a
vector and a factor, both of the same length, that were created as follows:

v <- c(40, 2, 83, 28,  58)
f <- factor(c('A', 'C', 'C', 'B', 'C'))

#*                    6.1 Splitting a Vector into Groups                   *
# You have a vector. Each element belongs to a different group, and the groups 
# are identified by a grouping factor You want to split the elements into
# groups.
# Suppose the vector is x and the factof is f. You can use the split function:
groups <- split(x, f)
# Or you can use the unstack function
groups <- unstack(data.frame(x, f))
# Both functions return a list of vectors, where each vector contains the 
# elements for one group

require(MASS)
df <- split(Cars93$MPG.city, Cars93$Origin) # returns list
median(df[[1]])
median(df[[2]])

#*                6.2 Applying a Function to Each List Element             *
# You have a list, and you want to apply a function to each element of the list
# Use either thte lapply function or the sapply function, depending upon the
# desired from of the result. lapply always returns the results in the list,
# whereas sapply returns the results in a vector if that is possible.

lst <- lapply(lst, fun)
vec <- sapply(lst, fun)

# These functions will call your function (fun, in the above example) once for 
# every element in the list. The function should expect one argument, an element
# from the list. 
# The s in sapply stands for simplify. The function tries to simplify the
# results into a vector or matrix. For that to happen, all the returned values
# must have the same length. If that length is 1, you get a vector. Otherwise
# you get a matrix. If the lengths vary, simplification can't happen and you get
# a list. 

#*                6.3 Applying a Function to Every Row                     *
# You have a matrix. You want to apply a function to every row, calculating the
# function result for each row

# use the apply function. Set the second argument to 1 to indicate row-by-row
# application of a function

results <- apply(mat, 1 fun) # mat is a matrix, fun is a function
# The apply function will call fun for each row, and assemle each results into a
# vector

#*                6.4 Applying a Function to Every Column                  *
# You have a matrix or data frame, and you want to apply a function to every
# column

# For a data frame, use the lapply or sapply functions. Either one will apply a
# function to successive columns of the data frame.

# For a matrix, use the apply function. Set the second argument to 2, which
# indicates column-by-column application of this function.

results <- apply(mat, 2, fun)
lst <- lapply(dfrm, fun)
vec <- sapply(dfrm, fun)

# You can use apply on data frames, too, but only if the data frame is 
# homogenous (ie either all numeric values or all character strings)
data(diamonds)
sapply(diamonds, class)

#*                6.5 Applying a Function to Groups of Data                *
# Your data elements occur in groups. You want to process the data by groups - 
# for example, summing by group or averaging by group

# Create a grouping factor (of the same length as your vector) that identifies
# the gropu of each corresponding datum. The use the tapply function, which
# apply a function to each group.
tapply(x, f, fun)
# Here, x is a vector, f is a grouping factor, and fun is a function. The 
# function should expect one argumeent, which is a vector of elements taken from
# x according to their group.

#*                6.6 Applying a Function to Groups of Rows                *
# You want to apply a function to groups of rows within a data frame

# Define a grouping factor -- that is a factor with one level for every row in
# your data frame -- that identifies the data groups.
# For each sub group of rows, the by function puts the rows into a temp data
# frame and calls your function with that argument. The by function collects the
# returned values into a list and returns the list.

by(dfrm, fact, fun)

# Here, dfrm is the data frame, fact is the grouping factor, and fun is a
# function., The function should expect one argument, a data frame
by(trials, trials$sex, summary)
models <- by(trials, trials$sex, function(df) lm(post~pre + dose1 + dose2,
                                                 data=df))

print(models)
lapply(models, confint)

#*           6.7 Applying a Function to Parallel Vectors or Lists           *
# You have a function, say f, that takes multiple arguments. You want to apply the
# function element-wise to vectors and obtain a vector result. Unfortunately, the
# function is not vectorized; that is, it works only on scalars. 

# Use the mapply function. It will apply the function f to your arguments
# element-wise

mapply(f, vec1, vec2, vec3)

There must be one vector for each argument expected by f. If the vector
arguments are of unequal length, the Recycling Rule is applied. 

The mapply function also works wiht list arguments.
mapply(f, lst1, lst2 , lst3)
