# ---------------------------------- TITLE -------------------------------------
# 04_LDAproj_samedatecombination.R
# AUTHOR: HARUKA TAKAGI
# DATE: JULY 14, 2020
# ENCODING: utf-8
# PYTHON VERSION: 3.7

# ---------------------------------- NOTES -------------------------------------
# The purpose of this script is to combine text files that have the same date. And
# get rid of the first page in some text files. (trim function). Run just on
# tealbook, greenbook & greenbook_mini.

# ---------------------------------- SETUP -------------------------------------

# Set up for necessary packages
library(dplyr)
library(tidyr)
library(readr)
library(readtext)
library(data.table)
library(quanteda)
library(tm)
library(stm)
library(readtext)
library(magrittr)
library(stringr)

# ---------------------------------- CODE --------------------------------------

# Run time calculation
start_time <- Sys.time()

# Set system encoding type
oldloc <- Sys.getlocale("LC_CTYPE")
Sys.setlocale("LC_CTYPE", "en_US.UTF-8")

# ---------------------------------- GREENBOOK_MINI --------------------------------------

# load in Greenbook document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_cleaned/Greenbook_mini'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# trim text to not include the introductory page
for(i in 1:nrow(gb_df)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(gb_df))))
  index_vec <- c()
  if (confidential_index_array <- length(str_locate_all(gb_df$text[i], pattern = "confidential")[[1]]) >= 4){
    confidential_index <- str_locate_all(gb_df$text[i], pattern = "confidential")[[1]][2]
  }
  strictly_index <- str_locate(gb_df$text[i], pattern = "strictly")[[1]]
  class_index <- str_locate(gb_df$text[i], pattern = "class")[[1]]
  index_vec <- c(index_vec, confidential_index)
  index_vec <- c(index_vec, strictly_index)
  index_vec <- c(index_vec, class_index)
  index_vec <- index_vec[!is.na(index_vec)]
  min_val <- min(index_vec)
  gb_df$text[i] <- substr(gb_df$text[i], min_val, nchar(gb_df$text[i]))
}

# Save file for cleanest version
for (i in 1:nrow(gb_df)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(gb_df))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_cleaned/Greenbook_mini'
  clean_filename <- gb_df$doc_id[i]
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  fileConn<-file(filepath_name)
  writeLines(gb_df$text[i], fileConn)
  close(fileConn)
  i = i + 1
}

# Create empty dataframe
comb_df <- data.frame(matrix(ncol = 2, nrow = 1))
x <- c("doc_id", "text")
colnames(comb_df) <- x

# Combine text of files with the same date
for (i in 1:(nrow(gb_df) - 1)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(gb_df))))
  date_1 <- substr(gb_df$doc_id[i], 5, 12)
  print(date_1)
  date_2 <- substr(gb_df$doc_id[i + 1], 5, 12)
  print(date_2)
  if (date_1 != date_2){
    comb_df <- rbind(comb_df, c(gb_df$doc_id[i], gb_df$text))
    i = i + 1
  }
  else {
    new_text <- paste(gb_df$text[i], gb_df$text[i + 1], sep = ' ', collapse = NULL)
    comb_df <- rbind(comb_df, c(gb_df$doc_id[i], new_text))
    i = i + 2
  }
}

# Merge last row to dataframe
new_text_last <- paste(gb_df$text[nrow(gb_df)], sep = ' ', collapse = NULL)
comb_df <- rbind(comb_df, c(gb_df$doc_id[nrow(gb_df)], new_text_last))

# Remove first NA row in dataframe
comb_df <- comb_df[-c(1), ]

# Drop latter section of row observations from dataframe that have the same date
drop_index <- c()
for (i in 1:nrow(comb_df)){
  is_latter <- substr(comb_df$doc_id[i], 17, 17) # for greenbooks
  print(is_latter)
  if (is_latter == '2'){ # fore greenbooks
    drop_index <- c(drop_index, i)
  }
}

# Drop part 2 text observations
comb_df <- comb_df[-c(drop_index), ]

# Save file for combined version
for (i in 1:nrow(comb_df)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(comb_df))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_combined/Greenbook_mini'
  clean_filename <- comb_df$doc_id[i]
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year, clean_filename, sep = '/'), 1, 255)
  fileConn<-file(filepath_name)
  writeLines(comb_df$text[i], fileConn)
  close(fileConn)
  i = i + 1
}


# ---------------------------------- GREENBOOK --------------------------------------

# load in Greenbook document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_cleaned/Greenbook'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# trim text to not include the introductory page
for(i in 1:nrow(gb_df)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(gb_df))))
  index_vec <- c()
  if (confidential_index_array <- length(str_locate_all(gb_df$text[i], pattern = "confidential")[[1]]) >= 4){
    confidential_index <- str_locate_all(gb_df$text[i], pattern = "confidential")[[1]][2]
  }
  strictly_index <- str_locate(gb_df$text[i], pattern = "strictly")[[1]]
  class_index <- str_locate(gb_df$text[i], pattern = "class")[[1]]
  index_vec <- c(index_vec, confidential_index)
  index_vec <- c(index_vec, strictly_index)
  index_vec <- c(index_vec, class_index)
  index_vec <- index_vec[!is.na(index_vec)]
  min_val <- min(index_vec)
  gb_df$text[i] <- substr(gb_df$text[i], min_val, nchar(gb_df$text[i]))
}

# Save file for cleanest version
for (i in 1:nrow(gb_df)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(gb_df))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_cleaned/Greenbook'
  clean_filename <- gb_df$doc_id[i]
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  fileConn<-file(filepath_name)
  writeLines(gb_df$text[i], fileConn)
  close(fileConn)
  i = i + 1
}

# Create empty dataframe
comb_df <- data.frame(matrix(ncol = 2, nrow = 1))
x <- c("doc_id", "text")
colnames(comb_df) <- x

# Combine text of files with the same date
for (i in 1:(nrow(gb_df) - 1)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(gb_df))))
  date_1 <- substr(gb_df$doc_id[i], 5, 12)
  print(date_1)
  date_2 <- substr(gb_df$doc_id[i + 1], 5, 12)
  print(date_2)
  if (date_1 != date_2){
    comb_df <- rbind(comb_df, c(gb_df$doc_id[i], gb_df$text))
    i = i + 1
  }
  else {
    new_text <- paste(gb_df$text[i], gb_df$text[i + 1], sep = ' ', collapse = NULL)
    comb_df <- rbind(comb_df, c(gb_df$doc_id[i], new_text))
    i = i + 2
  }
}

# Merge last row to dataframe
new_text_last <- paste(gb_df$text[nrow(gb_df)], sep = ' ', collapse = NULL)
comb_df <- rbind(comb_df, c(gb_df$doc_id[nrow(gb_df)], new_text_last))

# Remove first NA row in dataframe
comb_df <- comb_df[-c(1), ]

# Drop latter section of row observations from dataframe that have the same date
drop_index <- c()
for (i in 1:nrow(comb_df)){
  is_latter <- substr(comb_df$doc_id[i], 17, 17) # for greenbooks
  print(is_latter)
  if (is_latter == '2'){ # for greenbooks
    drop_index <- c(drop_index, i)
  }
}

# Drop part 2 text observations
comb_df <- comb_df[-c(drop_index), ]

# Save file for combined version
for (i in 1:nrow(comb_df)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(comb_df))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_combined/Greenbook'
  clean_filename <- comb_df$doc_id[i]
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year, clean_filename, sep = '/'), 1, 255)
  fileConn<-file(filepath_name)
  writeLines(comb_df$text[i], fileConn)
  close(fileConn)
  i = i + 1
}


# ---------------------------------- TEALBOOK --------------------------------------

# load in Greenbook document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_cleaned/Tealbook'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# trim text to not include the introductory page
for(i in 1:nrow(gb_df)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(gb_df))))
  index_vec <- c()
  if (confidential_index_array <- length(str_locate_all(gb_df$text[i], pattern = "confidential")[[1]]) >= 4){
    confidential_index <- str_locate_all(gb_df$text[i], pattern = "confidential")[[1]][2]
  }
  strictly_index <- str_locate(gb_df$text[i], pattern = "strictly")[[1]]
  class_index <- str_locate(gb_df$text[i], pattern = "class")[[1]]
  index_vec <- c(index_vec, confidential_index)
  index_vec <- c(index_vec, strictly_index)
  index_vec <- c(index_vec, class_index)
  index_vec <- index_vec[!is.na(index_vec)]
  min_val <- min(index_vec)
  gb_df$text[i] <- substr(gb_df$text[i], min_val, nchar(gb_df$text[i]))
}

# Save file for cleanest version
for (i in 1:nrow(gb_df)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(gb_df))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_cleaned/Tealbook'
  clean_filename <- gb_df$doc_id[i]
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  fileConn<-file(filepath_name)
  writeLines(gb_df$text[i], fileConn)
  close(fileConn)
  i = i + 1
}

# Create empty dataframe
comb_df <- data.frame(matrix(ncol = 2, nrow = 1))
x <- c("doc_id", "text")
colnames(comb_df) <- x

# Combine text of files with the same date
for (i in 1:(nrow(gb_df) - 1)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(gb_df))))
  date_1 <- substr(gb_df$doc_id[i], 5, 12)
  print(date_1)
  date_2 <- substr(gb_df$doc_id[i + 1], 5, 12)
  print(date_2)
  if (date_1 != date_2){
    comb_df <- rbind(comb_df, c(gb_df$doc_id[i], gb_df$text))
    i = i + 1
  }
  else {
    new_text <- paste(gb_df$text[i], gb_df$text[i + 1], sep = ' ', collapse = NULL)
    comb_df <- rbind(comb_df, c(gb_df$doc_id[i], new_text))
    i = i + 2
  }
}

# Merge last row to dataframe
new_text_last <- paste(gb_df$text[nrow(gb_df)], sep = ' ', collapse = NULL)
comb_df <- rbind(comb_df, c(gb_df$doc_id[nrow(gb_df)], new_text_last))

# Remove first NA row in dataframe
comb_df <- comb_df[-c(1), ]

# Drop latter section of row observations from dataframe that have the same date
drop_index <- c()
for (i in 1:nrow(comb_df)){
  is_latter <- substr(comb_df$doc_id[i], 21, 21) # For tealbook
  print(is_latter)
  if (is_latter == "b"){  # For tealbook
    drop_index <- c(drop_index, i)
  }
}

# Drop part 2 text observations
comb_df <- comb_df[-c(drop_index), ]

# Save file for combined version
for (i in 1:nrow(comb_df)){
  print(paste('Processing ', toString(i), ' out of ', toString(nrow(comb_df))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_combined/Tealbook'
  clean_filename <- comb_df$doc_id[i]
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year, clean_filename, sep = '/'), 1, 255)
  fileConn<-file(filepath_name)
  writeLines(comb_df$text[i], fileConn)
  close(fileConn)
  i = i + 1
}

