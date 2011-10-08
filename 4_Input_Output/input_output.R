#***************************************************************************
#***************************************************************************
#********************** Chapter 4: Input and Output ************************
#***************************************************************************
#***************************************************************************

#***************************************************************************
#********************** Chapter 4.1: Entering Data from the Keyboard *******
#***************************************************************************

scores <- data.frame() # Create empty data frame
scores <- edit(score) # Invoke editor, overwrite with edited data

points <- data.frame(
         label = c( 'Low', 'Mid', 'High'),
         lbound = c(    0,  0.67,   1.64),
         ubound = c(0.674,  1.64,   2.33)
         )

#***************************************************************************
#********************** Chapter 4.2: Printing Fewer Digits (or More Digits)*
#***************************************************************************
# Also see functions sprintf and formatC

# R normally formats floating-poing output to have seven digits
pi # [1] 3.141593
pi * 100 # [1] 314.1593 

print(pi, digits = 4)
print(100 * pi, digits = 4)

# cat does not give direct control formatting
cat(pi, '\n')
# use format first
cat(format(pi, digits=4), '\n')

# format full vector
pnorm(-3:3)
# finds the number of digits needed to print all number with at least 3 digits
print(pnorm(-3:3), digits=3)

q <- seq(from=0, to=3, by=0.5)
tbl <- data.frame(Quant = q, Lower = pnorm(-q), Upper = pnorm(q))
print(tbl, digits = 2)

#***************************************************************************
#********************** Chapter 4.3: Redirecting Output to a File ********** 
#***************************************************************************

answer = 'yes!'
cat('The answer is', answer, '\n', file='filename')

# use the sink function to redirect all ouptut from both print and cat. 
# Call sink with a filename argument to begin redirecting console output to 
# that file. When you are done, use sink with no argument to close the file and
# resume output to the console

sink('filename') # Begin writing output to the file
sink() # Resume writing output to console

#***************************************************************************
#********************** Chapter 4.4: Listing Files ************************* 
#***************************************************************************

list.files() # shows contents of working directory
list.files(recursive=T) # show contents of sub-directory too
list.files(all.files=TRUE) # show hidden files

#***************************************************************************
#****************** Chapter 4.5: Dealing with "Cannot Open File" in Windows* 
#***************************************************************************

# Don't use single back slashes in windows
samp <- read.csv('C:\Data\sample-data.csv') # BAD
samp <= read.csv('c:/Data/sample-data.csv') # OK 
samp <- read.csv('C:\\Data\\sample-data.csv') # OK

#***************************************************************************
#****************** Chapter 4.6: Reading Fixed-Width Records *************** 
#***************************************************************************

#records <- read.fwf('fixed-width.txt', widths=c(w1, w2, w3, ..., wn))
# -1 means there is a one-character space column which should be ignored
records <- read.fwf('fixed-width.txt', widths=c(10, 10, 4, -1, 4))

# By default R supplies funky, synthetic column names
# We can override that default by using col.names argument

records <- read.fwf('fixed-width.txt', widths = c(10, 10, 4, -1, 4), 
                    col.names = c('Last', 'First', 'Born', 'Died'))

#***************************************************************************
#****************** Chapter 4.7: Reading Tabular Data Files **************** 
#***************************************************************************

dfrm <- read.table('statisticians.txt')
class(dfrm$V1)

# To read.table from interpreting character strings as factors, set the
# stringsAsFactors parameter to FALSE
dfrm <- read.table('statisticians.txt', stringsAsFactor=FALSE)
class(dfrm$V1)

# Tell read.table which symbols are the same as missing values
dfrm <- read.table('statisticians.txt', na.strings='.')
dfrm <- read.table('statisticians.txt', na.strings='.', header = TRUE,
                   stringsAsFactors = TRUE)

#***************************************************************************
#****************** Chapter 4.8: Reading from CSV Files ******************** 
#***************************************************************************
# see chapter 4.7 above

tbl <- read.csv('filename')
tbl <- read.csv('filename', header = FALSE, comment.char="'")

#***************************************************************************
#****************** Chapter 4.9: Writing to CSV Files ********************** 
#***************************************************************************

write.csv(tbl, file = 'table-data.csv', row.names=T)
# write.csv cannot append lines to a file. Use write.table instead for that.

#***************************************************************************
#****************** Chapter 4.10 & 4.11 : Reading Data from the Web ******** 
#***************************************************************************

require(XML) # Not available for R version 2.13.1
# also requires libxml2

# Maybe would use RCurl instead?
tbl <- read.csv('http://www.example.com/download/data.csv')
tbl <- readHTMLTable(url, which=3)
url <- 'http://en.wikipedia.org/wiki/World_Population'
tbls <- headHTMLTable(url)
length(tbls)
tbl <- readHTMLTable(url, which = 3)
tbl[, c(2, 3)]

#***************************************************************************
#****************** Chapter 4.12 Reading Files with a Complex Structure **** 
#***************************************************************************

# Use the readlines function to read individual lines; then process them as
# strings to extract data items

# Or use the scan function to read individual tokens and use the argument 
# 'what' to describe the stream of tokens in your life. The function can convert
# tokens into data and then assemble the data into records

lines <- readLines('input.txt')
lines <- readLines('input.txt', n=10) # Read 10 lines and stop

# The scan function reads one token at a time and handles it according to your
# instructions. The first argument is either a filename or connection. The 2nd
# argument is a called 'what', and describes the tokens that scan should expect
# in the input file. 
singles <- scan('scan_test.txt', what=numeric(0))
triples <- scan('triples.txt', what = list(date = character(0),
                                           high = numeric(0), 
                                           low = numeric(0)))
# Read the wseries dataset:
# - skip the first 35 lines
# - then read 23 lines of data
# - the data occurs in pairs: a year and a pattern (char string)

world.series <- scan('http://lib.stat.cmu.edu/datasets/wseries', 
                     skip = 35,
                     nlines = 23,
                     what = list(year = integer(0),
                                 pattern = character(0)),
                     )
perm <- order(world.series$year)
world.series <- list(year = world.series$year[perm],
                     pattern = world.series$pattern[perm])

world.series$pattern

#***************************************************************************
#****************** Chapter 4.13 Reading from MySQL Databases **************
#***************************************************************************

# 1. Install RMySQL package 
# 2. open a database connection using the dbConnect function
# 3. Use dbGetQuery to initiate a SELECT and return the result sets
# 4. Use dbDisconnect to terminate the database connection when you are done

library(RMySQL)
con <- dbConnect(MySQL(), user = 'userid', password = 'pswd',
                 host = 'hostname', client.flag = CLIENT_MUTLI_RESULTS)
# Use the security mechanism of MySQL instead. Put connection parameters into
# MYSQL config file in $HOME/.my.cnf or C:\my.cnf on Windows

con <- dbConnect(MySQL(), client.flag = CLIENT_MUTLI_RESULTS)
sql <- "SELECT * from SurveyResults WHERE City = 'CHICAGO'"
rows <- dbGetQuery(con, sql)

if (dbMoreResults(con)) dbNextResult(con)

dbDisconnect(con)

#***************************************************************************
#****************** Chapter 4.14 Saving and Trasnporting Objects ***********
#***************************************************************************

# write binary data
save(myData, file = 'myData.RData')
load('myData.RData')

# write ASCII format
dput(myData, file = 'myData.RData')

# Note quotes around variable name
dump('myData', file = 'myData.txt')
