#***************************************************************************
#***************************************************************************
#********************** Chapter 7: Strings and Dates ***********************
#***************************************************************************
#***************************************************************************

#*                    Classes for Strings and Dates                        *

The following date related classes are include in base R.

# Date
# The Date class can represent a calendar data but not a clock time. It is a
# solid, general-purpose class for working with dates, including conversions,
# formatting, basic date arithmetic, and time-zone handling. Most of the date
# related recipes in this book are built on the Date class.

# POSIXct
# This is a datetime class, and it can represent a moment in time with an 
# accuracy of one second. Internally, the datetime is stored as the number of
# seconds since 1/1/1970, and so is a very compact representation. This class is
# recommended for storing datetime information (eg, in data frames)

# POSIXlt
# This is also a datetime clas, but the representation is stored in a 
# nine-element list that includes the year, month, day, hour, minute, and
# second. That representation makes it easy to extract data parts, such as
# month or hour. Obviously, this representation is much less compact that the
# POSIXct class; hence it is normally used for intermediate processing and not
# for storing data. 
as.Date
as.POSIXct
as.POSIXlt

#*                    7.1 Getting the Length of a String                   *

# You want to know the length of a string
Use the nchar function

#*                    7.2 Concatenating Strings                            *
You want to join together two or more strings
paste()
    
#*                    7.3 Extracting Substrings                            *
# You want to extract a portion of a string according to position
# Use substr. The substr function takes a string, a starting point, and an 
# ending point. It returns the substring between the starting to ending points.
substr(string, start, end)

#*                    7.4 Splitting a String According to a Delimiter      *
Use strplit, which takes two arguments -- the string and the delimiter of the
substrings.
strsplit(string, delimiter)
path <- '/home/idris/data/trials.csv'
strsplit(path, '/')
Also you can see the R regular expression package regexp

#*                    7.5 Replacing Substring                              *
# Within a string, you want to replace one substring with another
Use sub to replace the first instance of a string
sub(old, new, string)
Use gsub to replace all instances of a string
gsub(old, new, string)
