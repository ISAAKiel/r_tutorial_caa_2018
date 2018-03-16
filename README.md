# Processing Radiocarbon Data with R

*Martin Hinz, Clemens Schmid (CAU Kiel)*

Documents and scripts for the Workshop 'Processing Radiocarbon Data with R' at the [2018 Computer Applications and Quantitative Methods in Archaeology (CAA) International Conference](http://2018.caaconference.org/).

## Abstract

Dealing with 14C dates is one of THE essential activities that occupy many archaeologists today. Oxcal is one impressive instrument for many daily routines with 14C dates. But there are some aspects where a proper statistical tool comes in handy. In this workshop we will explore the possibilities of R to deal with 14C dates.

We will briefly introduce several R packages that are specifically designed for this purpose: rcarbon, ArchaeoPhases and archSeries. Then we will turn to Bchron, a mature and widely-used package, and oxcAAR, our package to connect Oxcal to R. We will conduct simple calibration as well as Bayesian calibration and visualise the results with powerful tools in R.

In the last part of the workshop we will use R as a simulation engine for Oxcal, explore a Bayesian sequence and the confidence intervals for a sum calibration. Data for this bulk analysis can be obtained from openly accessible archives via our R package c14databases.
To fully take advantage of the practical part of the workshop you must bring your own laptop. Please install or update R and RStudio, and install the above mentioned packages (instructions available at https://isaakiel.github.io).

The workshop is primarily aimed at archaeologists who already have basic knowledge of R and radiocarbon data. Nevertheless, participants who do not yet have this experience are also welcome.

The development of this tutorial is a dynamic process that we would like to share and disclose through Github. Please note that data, scripts and texts in this "work-in-progress" archive may be incomplete and some scripts may not yet be functional. 

## Basic informations

### Time & Location

This workshop will take place Monday 19 March, 13:45-17:45, in Seminar Room F, in the Geographical Institute building at [Rümelinstraße 19-23, 72074 Tübingen](https://www.google.de/maps/place/R%C3%BCmelinstra%C3%9Fe+19,+T%C3%BCbingen/@48.5239808,9.0538022,17z/data=!3m1!4b1!4m5!3m4!1s0x4799e52b54533365:0xe1677f7088d7e408!8m2!3d48.5239808!4d9.0559909).

### Preparations

The tutorial is based on the participants using their own laptops. We have experienced that maximum learning success is achieved when the participants do not work on a foreign system in a computer pool but with their own devices. The [Basic version of R](https://www.r-project.org/) should be installed for the tutorial (see links below). As a development environment we will use [RStudio](https://www.rstudio.com/products/rstudio/) which should also be installed. Additionally some system libraries and R packages are needed (see below). Lecturers can provide support for Windows, Mac and Linux systems if necessary. However, we urge each participant to install the necessary software before the tutorial. If you have any questions or problems, please contact us before the workshop.  

#### Required software

* [R: The R Project for Statistical Computing](https://www.r-project.org/):
	* The latest installation files: [The Comprehensive R Archive Network](http://ftp5.gwdg.de/pub/misc/cran/)
	* Windows: [Installation tutorial](https://github.com/eScienceCenter/R-Tutorial_20170707/blob/master/Installationsanleitung_Windows.pdf) | [Installation tutorial video](https://www.youtube.com/watch?v=P783pgSd-ik)
* [RStudio](https://www.rstudio.com/products/rstudio/download/)
* R Packages: We need a lot of them. Please use the following code to install all of them at once. If the installation fails and you're not on a Windows client check for missing system dependencies (see below). If you're on a Windows client check if the failing package has no prebuilt binaries yet and if you therefore have to fall back to an older package version.

```r
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
```

* Software libraries (only for Linux and Mac users): Some of the packages we use require more other software that has to be installed on your system. It's tricky to estimate what exactly we need. Here's a script to install everything on an ubuntu trusty sytem. This could work also on other ubuntu and debian versions and their derivatives. If you're on an other Linux distribution you have to find the suitable packages for your OS. For Mac [this](https://github.com/r-spatial/sf#macos) should get you started.

```shell
apt-get update

apt-get install --no-install-recommends \
  libcurl4-openssl-dev \
  libssl-dev \
  libxml2-dev \
  udunits-bin \
  libproj-dev \
  libgeos-dev \
  libgdal-dev \
  libudunits2-dev \
  qpdf
```

* [Rtools](https://cran.r-project.org/bin/windows/Rtools/) (only for Windows users): It might not be necessary for this workshop, but it's inevitable if you want to use R beyond very basic applications.

#### Data

In the course of the tutorial we will 'create' small amounts of data ourselves or download them from publicly accessible repositories. It is not necessary to import data beforehand. However, it may make sense to bring your own data with you so that the steps can be carried out using this data.

## Copyright and Licence

The content of the repository is licenced under [GPL-2.0](LICENSE). This workshop is created and organized by the [ISAAKiel group (Initiative for Statistical Analysis in Archaeology Kiel)](https://isaakiel.github.io).

![ISAAK Logo](https://raw.githubusercontent.com/ISAAKiel/ISAAKiel.github.io/master/elements/logo.png)
