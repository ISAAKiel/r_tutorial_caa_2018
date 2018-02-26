# Processing Radiocarbon Data with R

*Martin Hinz, Clemens Schmid (CAU Kiel)*

Documents and scripts for the Workshop 'Processing Radiocarbon Data with R' at the [2018 Computer Applications and Quantitative Methods in Archaeology (CAA) International Conference](http://2018.caaconference.org/).

## Abstract

Dealing with 14C dates is one of THE essential activities that occupy many archaeologists today. Oxcal is one impressive instrument for many daily routines with 14C dates. But there are some aspects where a proper statistical tool comes in handy. In this workshop we will explore the possibilities of R to deal with 14C dates.

We will briefly introduce several R packages that are specifically designed for this purpose: rcarbon, ArchaeoPhases and archSeries. Then we will turn to Bchron, a mature and widely-used package, and oxcAAR, our package to connect Oxcal to R. We will conduct simple calibration as well as Bayesian calibration and visualise the results with powerful tools in R.

In the last part of the workshop we will use R as a simulation engine for Oxcal, explore a Bayesian sequence and the confidence intervals for a sum calibration. Data for this bulk analysis can be obtained from openly accessible archives via our R package c14databases.
To fully take advantage of the practical part of the workshop you must bring your own laptop. Please install or update R and RStudio, and install the above mentioned packages (instructions available at https://isaakiel.github.io).

The workshop is primarily aimed at archaeologists who already have basic knowledge of R and radiocarbon data. Nevertheless, participants who do not yet have this experience are also welcome.

This repository is used to provide documents and scripts for the Turorial.

## Basic informations

The tutorial is based on the participants using their own laptops. We have experienced that maximum learning success is achieved when the participants do not work on a foreign system in a computer pool but with their own devices. The [Basic version of R](https://www.r-project.org/) should be installed for the tutorial (see links below). As a development environment we will use [RStudio](https://www.rstudio.com/products/rstudio/) which should also be installed. Additionally some packages are needed. These can be installed automatically by a small R-script, which we will provide shortly before the tutorial. Lecturers can provide support for Windows, Mac and Linux systems if necessary. However, we urge each participant to install the necessary software before the tutorial. If you have any questions or problems, please contact us before the workshop.  

Further information as well as all scripts, data and instructions will be available here: https://github.com/ISAAKiel/r_tutorial_caa_2018
The development of this tutorial is a dynamic process that we would like to share and disclose through Github. Please note that data, scripts and texts in this "work-in-progress"archive may be incomplete and some scripts may not yet be functional. 

## Required software
* [R: The R Project for Statistical Computing](https://www.r-project.org/):
	* The latest installation files: [The Comprehensive R Archive Network](http://ftp5.gwdg.de/pub/misc/cran/)
* [RStudio](https://www.rstudio.com/products/rstudio/download/)
* Packages: *we will offer an R-script shortly before the tutorial, which automatically installs the necessary packages; instructions follow*

[The installation of the required software (under Windows) is described here](https://github.com/dirkseidensticker/R-Tutorial_CAA2016/blob/master/Installation instructions_Windows.md)

There is also an ISAAK video Tutorial available:

[![[IBR-en 001] Install R and R Studio on Windows](https://img.youtube.com/vi/P783pgSd-ik/0.jpg)](https://www.youtube.com/watch?v=P783pgSd-ik)

## Data
In the course of the tutorial we will 'create' small amounts of data ourselves or download them from publicly accessible repositories. It is not necessary to import data beforehand. However, it may make sense to bring your own data with you so that the steps can be carried out using this data.

## Copyright and Licence

The content of the repository is licenced under [GPL-2.0](LICENSE). This workshop is created and organized by the [ISAAKiel group (Initiative for Statistical Analysis in Archaeology Kiel)](https://isaakiel.github.io).

![ISAAK Logo](https://raw.githubusercontent.com/ISAAKiel/ISAAKiel.github.io/master/elements/logo.png)
