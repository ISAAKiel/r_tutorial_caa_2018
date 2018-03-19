# Welcome to our handout script for our tutorial at CAA 2018 on 14C processing.
# With this script we will provide you some code snippets to avoid tedious excessive typing of code 

###################
# 0. Preparations #
###################

# At first we have to prepare the R environment. We will need a few packages, especially for the spatial components of c14bazAAR. Most of the packages will not be necessary if you just want to use oxcAAR

# install magrittr to get the %>% operator
install.packages(c("magrittr"), repos = "https://ftp.gwdg.de/pub/misc/cran/")
library(magrittr)

# packages we (might) need for this workshop
necessary_packages <- c(
  "Bchron", "countrycode", "crayon", "dataverse", "devtools", 
  "dplyr", "jsonlite", "knitr", "lwgeom", "magrittr", "maps", 
  "maptools", "mapview", "pbapply", "plyr", "RCurl", "raster", 
  "readr", "readxl", "rgdal", "rgeos", "rmarkdown", "rworldxtra", 
  "sf", "sp", "spatstat", "stringdist", "stringr", "testthat", 
  "tibble", "tidyr", "tidyverse"
)

# create a list of already installed packages
already_installed_packages <- installed.packages() %>% as.data.frame %$% Package %>% as.character

# determine missing packages
missing_packages <- necessary_packages[necessary_packages %in% already_installed_packages %>% `!`]

# install them
if (identical(missing_packages, character(0))) { 
  message("everything already installed") 
} else {
  install.packages(missing_packages, repos = "https://ftp.gwdg.de/pub/misc/cran/")
}
# if you're on Windows you have to rely on packages with prebuilt binaries 
# (except you have the Rtools installed)

# finally: our packages c14bazAAR and oxcAAR
devtools::install_github(
  repo = c("ISAAKiel/c14bazAAR", "ISAAKiel/oxcAAR")
)

# Now that everything is set up, we might start with our lecture:

########################
# 1. Basic calibration #
########################

## 1.1 just doing calibration

# fill in your code here

## 1.2 Sequential calibration

# ---------------- your code ----------------

# fill in your code here

# ---------------- your code ----------------

##########################################
#
# The following snippet transforms an (well formed) dataframe of 14C dates into a sequential calibration code for OxCal
#
##########################################

# ---------------- snip ----------------
# make a list of strings, an element per phase with the R_Dates
phased_dates <- by(my_sequence,my_sequence$phase, function(x)
  R_Date(x$name,x$bp,x$std))

# Wrap the dates in Phases
phases <- Phase(names=c("1","2","3"), r_dates_strings = phased_dates)

# make an vector with some names for the boundaries
boundary_name <- c("begin","1->2","2->3","end")

# wrap the phases in boundaries
my_sequence_elements <- wrap_in_boundaries(phases, boundary_name)

# Wrap the whole thing in a sequence
my_oxcal_code <- Sequence(my_sequence_elements, name = "my_sequence")

cat(my_oxcal_code)

# ---------------- snip ----------------

##########################################
#
# The following snippet processes custom OxCal code in OxCal itself
#
##########################################

# ---------------- snip ----------------

# call Oxcal and read and parse the result
my_result_file <- executeOxcalScript(my_oxcal_code)
my_result_text <- readOxcalOutput(my_result_file)
my_result_data <- parseOxcalOutput(my_result_text, only.R_Date = F)

my_result_data

# ---------------- your code ----------------

# fill in your code here

# ---------------- your code ----------------


################
# 2. c14bazAAR #
################

