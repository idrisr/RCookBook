#***************************************************************************
#***************************************************************************
#********************** Chapter 3: Navigating the Software *****************
#***************************************************************************
#***************************************************************************

#***************************************************************************
#********************** 3.2 Saving Your Workspace **************************
#***************************************************************************

save.image()

#***************************************************************************
#********************** 3.3 Viewing Your Command History *******************
#***************************************************************************

history()
history(100)
history(Inf) # show entire saved history

#***************************************************************************
#********************** 3.4 Saving the Result of the Previous Command ******
#***************************************************************************

# You typed an expression into R that calc'ed a value, but you forgot to save
# the value

.Last.value

#***************************************************************************
#********************** 3.5 Display the Search Path ************************
#***************************************************************************

# show which packages are loaded
search()
require(ggplot2)
search()

#***************************************************************************
#********************** 3.6 Accessing the Functions in a Package ***********
#***************************************************************************

require() # returns a boolean about whether loading the package worked
library() # errors out if a package isn't there

# if you try to load the same package twice, R won't reload it
detach(package:ggplot2)

#***************************************************************************
#********************** 3.7 Accessing Built-in Datasets ********************
#***************************************************************************

data(dsname, package='pkgname')
data(diamonds, package='ggplot2')
head(pressure)
help(diamonds)

#***************************************************************************
#********************** 3.8 Viewing the List of Installed Packages *********
#***************************************************************************

library()
installed.packages()
installed.packages()[,c("Package", "Version")]

#***************************************************************************
#********************** 3.9 Installing Packages from CRAN ******************
#***************************************************************************

install.packages('latest_greatest_library')

#***************************************************************************
#********************** 3.10 Setting a Default CRAN Mirror *****************
#***************************************************************************

chooseCRANmirror()
options('repos')[[1]][1]

#***************************************************************************
#********************** 3.12 Running a Script ******************************
#***************************************************************************

source('myScript.R')

#***************************************************************************
#********************** 3.13 Running a Batch Script ************************
#***************************************************************************

# Problem: You are writing a command script, such as a shell script in Unix or
# OSX or a BAT Script in Windows. Inside your script, you want to execute an R
# Script

# Run the R program with CMD BATCH subcommmand, giving the script name and the
# output file name:
# $ R CMD BATCH scriptfile outputfile

# If you want the output send to stdout or if you need to pass command-line
# arguments to the script, consider the Rscript command instead:
# RScript scriptfile arg1 arg2 arg3

# Other useful options in batch mode include the following:
# --slave 
# --no-restore
# --no-save
# --no-init-file

#***************************************************************************
#********************** 3.15 Locating the R Home Directory *****************
#***************************************************************************

Sys.getenv("R_HOME")

#***************************************************************************
#********************** 3.16 Customizing R *********************************
#***************************************************************************

help(options)
# browser
# editor
# prompt
# warn
# pre-load packages
# put it into .Rprofile require('the_package_I_use_so_much')


