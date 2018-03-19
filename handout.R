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

# ======== snip ========
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

# ======== snip ========

##########################################
#
# The following snippet processes custom OxCal code in OxCal itself
#
##########################################

# ======== snip ========

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

# might be necessary to detach rcarbon first due to 'calibrate()' function
# detach('package:rcarbon')

# ---------------- your code ----------------

# fill in your code here

# ---------------- your code ----------------

##########################################
#
# The following snippet filters a c14datelist for dates within a range of (4000 - 4500 calBP).
#
##########################################

# ======== snip ========

dates_4000_4500 <- calibrated %>%
  dplyr::select(labnr, calrange) %>%
  tidyr::unnest() %>%
  dplyr::filter(
    from >= 4000 & from <= 4500 |
      to >= 4000 & to <= 4500
  ) %$%
  labnr %>%
  unique

calibrated[calibrated$labnr %in% dates_4000_4500, ]

# ======== snip ========

# ---------------- your code ----------------

# fill in your code here

# ---------------- your code ----------------

##########################################
#
# The following snippet get all the dates of Baden-Würtemberg within the range of 7500 and 2700 cal BP (!). 
#
##########################################

# ======== snip ========

#### get all dates (again)

all_dates <- c14bazAAR::get_all_dates()

#### download shapefile from Baden-Württemberg ####

# create a tempfile
temp <- tempfile()

# download archive with shapefile
utils::download.file(
  "https://www.lgl-bw.de/lgl-internet/web/sites/default/de/07_Produkte_und_Dienstleistungen/Open_Data_Initiative/Galerien/Dokumente/AX_Gebiet_Bundesland.zip", 
  temp, 
  quiet = TRUE
)

# unzip archive in tempdir
utils::unzip(
  temp,
  exdir = tempdir()
)

# read shapefile into R
bawue_sf <- st_read(file.path(tempdir(), "AX_Gebiet_Bundesland.shp"))

plot(bawue_sf$geometry)

#### prepare date dataset ####

# reduce date selection (to reduce calculation time)
sw_germany_dates_1 <- all_dates %>%
  dplyr::filter(lat < 50, lat > 47, lon < 11, lon > 7.5)

sw_germany_dates_2 <- sw_germany_dates_1 %>%
  as.c14_date_list() %>%
  classify_material() %>%
  dplyr::filter(material_thes != "charcoal", material_thes != "wood")

sw_germany_dates_3 <- sw_germany_dates_2 %>%
  as.c14_date_list() %>%
  determine_country_by_coordinate() %>%
  dplyr::filter(country_coord == "Germany")

sw_germany_dates_4 <- sw_germany_dates_3 %>%
  as.c14_date_list() %>%
  remove_duplicates()

# make c14_date_list a sf object and transform coordinates to ETRS89 / UTM zone 32N reference system
sw_germany_dates_sf <- sw_germany_dates_4 %>%
  as.c14_date_list()%>%
  as.sf %>%
  st_transform(crs = 25832)

plot(sw_germany_dates_sf$geom, add = TRUE, col = "black")

#### intersect shape with dates ####

# spatial intersection to find dates within Baden-Württemberg
bawue_dates_sf <- sw_germany_dates_sf %>%
  st_intersection(y = bawue_sf)

plot(bawue_dates_sf$geom, add = TRUE, col = "red")

# transform this sf file to a data.frame
bawue_dates <- bawue_dates_sf
st_geometry(bawue_dates) <- NULL
colnames(bawue_dates) <- gsub("data.", "", colnames(bawue_dates))

#### final selection by timeframe

# calibrate the dates in this selection
bawue_calibrated <- bawue_dates %>%
  as.c14_date_list() %>%
  calibrate(choices = "calprobdistr")

# select dates by timeframe
bawue_final <- bawue_calibrated %>%
  unnest() %>%
  dplyr::filter(
    calage > 2700, calage < 7500
  ) %>%
  dplyr::group_by(labnr) %>%
  dplyr::do(head(., n = 1)) %>% 
  dplyr::ungroup()

#saveRDS(bawue_final, file = "bawue_final.RDS")

# ======== snip ========

###################################
# 3. Mass operations on 14C dates #
###################################

# ---------------- your code ----------------

# fill in your code here

# ---------------- your code ----------------

## 3.1 simple sum calibration

##########################################
#
# The following snippet is doing our sum calibration for Baden-Würtemberg. 
#
##########################################

# ======== snip ========

my_result_data <- bawue_sum_code %>%
  executeOxcalScript() %>%
  readOxcalOutput() %>%
  parseOxcalOutput(only.R_Date = FALSE, first = TRUE)

str(my_result_data)

# ======== snip ========

# ---------------- your code ----------------

# fill in your code here

# ---------------- your code ----------------


## 3.2 Binning

##########################################
#
# The following snippet bins the 14C dates on site level
#
##########################################

# ======== snip ========

# First, we add another column to our data, containing the R_Date string for that date:

bawue_final %<>% rowwise() %>%            # for each date (=row)
  mutate(oxcal_string = R_Date(labnr,     # add a column containing the R_Date code
                               c14age,
                               c14std)) %>%
  ungroup()                               # remove the rowwise grouping again

bawue_final %>% select(sourcedb,labnr,c14age, c14std, oxcal_string)

# Then we clue them together per site

site_sums <- bawue_final %>%       # Take the dates
  group_by(site) %>%               # per site do
  summarise(
    oxcal_string = paste(
      oxcal_string, 
      collapse = "\n")             # join the strings by a line break
  )
site_sums

# finally, we wrap everything into sum commands

bawue_sum_code <- site_sums %$%                               # finally take the strings
  oxcal_Sum(oxcal_string = oxcal_string, name = site) %>%     # wrap them in sum
  paste(collapse = "\n") %>%                                  # join the strings by line break
  oxcal_Sum(name = "outer sum")                               # wrap the whole thing in a sum

cat(substr(bawue_sum_code,1,253))
# ======== snip ========

# ---------------- your code ----------------

# fill in your code here

# ---------------- your code ----------------

# 3.3 Simulating sum calibrations

# ---------------- your code ----------------

# fill in your code here

# ---------------- your code ----------------



##########################################
#
# The following snippet calculates and plots the 95% confidence intervals from our simulation
#
##########################################

# ======== snip ========

alpha = .05

envelope <- sim_result %>% group_by(dates) %>% summarize(low=quantile(probabilities, alpha / 2),
                                                         high=quantile(probabilities, 1 - alpha / 2))

ggplot() +
  geom_ribbon(data = envelope, aes(x=dates,ymin=low, ymax = high), alpha = .5) + 
  geom_line(data = my_sum_result, aes(x=dates,y=probabilities), color="red") + xlim(time_window)

# ======== snip ========

##########################################
#
# The following snippet smoothes the sum calibration using a moving average filter
#
##########################################

# ======== snip ========

ma <- function(x,n=10){stats::filter(x,rep(1/n,n), sides=2)} # The smoothing function

my_sum_result %<>% mutate(probabilities_smoothed = ma(probabilities))

ggplot() +
  geom_ribbon(data = envelope, aes(x=dates,ymin=low, ymax = high), alpha = .5) + 
  geom_line(data = my_sum_result, aes(x=dates,y=probabilities), color="red") + 
  geom_line(data = my_sum_result, aes(x=dates,y=probabilities_smoothed), color="blue") + xlim(time_window)

# ======== snip ========

##########################################
#
# The following snippet smoothes the confidence envelope using a moving average filter
#
##########################################

# ======== snip ========

envelope %<>% mutate(low_smoothed = ma(low), high_smoothed = ma(high))

ggplot() +
  geom_ribbon(data = envelope, aes(x=dates,ymin=low_smoothed, ymax = high_smoothed), alpha = .5) + 
  geom_line(data = my_sum_result, aes(x=dates,y=probabilities_smoothed), color="blue") + xlim(time_window)

# ======== snip ========

##########################################
#
# The following snippet is doing the full analysis with 1000 repetitions.
# Uncomment and run only if you have enough time!
# On my computer it will take 1 HOUR!
#
##########################################

# ======== snip ========

# sim_result <- bawue_final %>% bootstrap(1000) %>% do(
#   oxcalSumSim(
#     n = nrow(bawue_final),
#     stds = sample(bawue_final$c14std),
#     timeframe_begin = -5500,
#     timeframe_end = -700,
#     date_distribution = "uniform"
#   )$raw_probabilities
# )
# 
# envelope <- sim_result %>% group_by(dates) %>% summarize(low=quantile(probabilities, alpha / 2),
#                                                          high=quantile(probabilities, 1 - alpha / 2))
# 
# my_sum_result %<>% mutate(probabilities_smoothed = ma(probabilities))
# 
# envelope %<>% mutate(low_smoothed = ma(low), high_smoothed = ma(high))
# 
# ggplot() +
#   geom_ribbon(data = envelope, aes(x=dates,ymin=low_smoothed, ymax = high_smoothed), alpha = .5) + 
#   geom_line(data = my_sum_result, aes(x=dates,y=probabilities_smoothed), color="blue") + xlim(time_window)

# ======== snip ========
