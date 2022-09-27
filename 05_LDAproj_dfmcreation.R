# ---------------------------------- TITLE -------------------------------------
# 05_LDAproj_dfmcreation.R
# AUTHOR: HARUKA TAKAGI
# DATE: JULY 14, 2020
# ENCODING: utf-8
# PYTHON VERSION: 3.7

# ---------------------------------- NOTES -------------------------------------
# The purpose of this script is to create a csv file of a dataframe with all 
# texts and create a document frequency matrix. Preprocess file consists of combined
# Greenbook_mini, Greenbook & Tealbook + cleaned version of Beigebook and Bluebook.
# Manually copy files into preprocess file.

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

# load in document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_preprocess/Greenbook_mini'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Turn clean texts into corpus
gb_clean_corpus <- corpus(gb_df)

# Tokenize clean corpus
gb_clean_tokens <- tokens(gb_clean_corpus)

# Stem the tokens
gb_clean_tokens <- tokens_wordstem(gb_clean_tokens, language = quanteda_options("language_stemmer"))

# Necessary for memory management
rm(gb_clean_corpus)

# Save file for stemmed version
for (i in 1:length(gb_clean_tokens)){
  print(paste('Processing ', toString(i), ' out of ', toString(length(gb_clean_tokens))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_stemmed/Greenbook_mini'
  clean_filename <- docnames(gb_clean_tokens[i])
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  tokens_txt <- paste(gb_clean_tokens[[i]], collapse = ' ')
  fileConn<-file(filepath_name)
  writeLines(tokens_txt, fileConn)
  close(fileConn)
  i = i + 1
}

# Stemmed directory file path
stemmed_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_stemmed/Greenbook_mini'

# Stemmed dataframe file path
dataframe_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_dataframe/Greenbook_mini.csv'

# Reads text files
stem_df <- readtext(paste0(stemmed_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Write dataframe as csv
write.csv(stem_df, dataframe_directory, row.names = FALSE)

# Turn clean tokens into a document frequency matrix
gb_dfm <- dfm(gb_clean_tokens)

# Location of document frequency matrix
dfm_loc <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_documentfrequencymatrix/Greenbook_mini_dfm.csv'

# Convert alternative document frequency matrix to dataframe
gb_dfm_df<- convert(gb_dfm, to = "data.frame")

# Write new document frequency matrix as new csv file for original dfm and modified dfm
write.csv(gb_dfm_df, dfm_loc, row.names = FALSE)

# Run time calculation
end_time <- Sys.time()

# Output run time for 25 text files
run_time <- end_time - start_time
print(run_time)
 
# ---------------------------------- GREENBOOK --------------------------------------

# load in document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_preprocess/Greenbook'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Turn clean texts into corpus
gb_clean_corpus <- corpus(gb_df)

# Tokenize clean corpus
gb_clean_tokens <- tokens(gb_clean_corpus)

# Stem the tokens
gb_clean_tokens <- tokens_wordstem(gb_clean_tokens, language = quanteda_options("language_stemmer"))

# Necessary for memory management
rm(gb_clean_corpus)

# Save file for stemmed version
for (i in 1:length(gb_clean_tokens)){
  print(paste('Processing ', toString(i), ' out of ', toString(length(gb_clean_tokens))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_stemmed/Greenbook'
  clean_filename <- docnames(gb_clean_tokens[i])
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  tokens_txt <- paste(gb_clean_tokens[[i]], collapse = ' ')
  fileConn<-file(filepath_name)
  writeLines(tokens_txt, fileConn)
  close(fileConn)
  i = i + 1
}

# Stemmed directory file path
stemmed_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_stemmed/Greenbook'

# Stemmed dataframe file path
dataframe_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_dataframe/Greenbook.csv'

# Reads text files
stem_df <- readtext(paste0(stemmed_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Write dataframe as csv
write.csv(stem_df, dataframe_directory, row.names = FALSE)

# Turn clean tokens into a document frequency matrix
gb_dfm <- dfm(gb_clean_tokens)

# Location of document frequency matrix
dfm_loc <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_documentfrequencymatrix/Greenbook_dfm.csv'

# Convert alternative document frequency matrix to dataframe
gb_dfm_df<- convert(gb_dfm, to = "data.frame")

# Write new document frequency matrix as new csv file for original dfm and modified dfm
write.csv(gb_dfm_df, dfm_loc, row.names = FALSE)

# Run time calculation
end_time <- Sys.time()

# Output run time for 25 text files
run_time <- end_time - start_time
print(run_time)

# ---------------------------------- BLUEBOOK --------------------------------------

# load in document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_preprocess/Bluebook'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Turn clean texts into corpus
gb_clean_corpus <- corpus(gb_df)

# Tokenize clean corpus
gb_clean_tokens <- tokens(gb_clean_corpus)

# Stem the tokens
gb_clean_tokens <- tokens_wordstem(gb_clean_tokens, language = quanteda_options("language_stemmer"))

# Necessary for memory management
rm(gb_clean_corpus)

# Save file for stemmed version
for (i in 1:length(gb_clean_tokens)){
  print(paste('Processing ', toString(i), ' out of ', toString(length(gb_clean_tokens))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_stemmed/Bluebook'
  clean_filename <- docnames(gb_clean_tokens[i])
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  tokens_txt <- paste(gb_clean_tokens[[i]], collapse = ' ')
  fileConn<-file(filepath_name)
  writeLines(tokens_txt, fileConn)
  close(fileConn)
  i = i + 1
}

# Stemmed directory file path
stemmed_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_stemmed/Bluebook'

# Stemmed dataframe file path
dataframe_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_dataframe/Bluebook.csv'

# Reads text files
stem_df <- readtext(paste0(stemmed_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Write dataframe as csv
write.csv(stem_df, dataframe_directory, row.names = FALSE)

# Turn clean tokens into a document frequency matrix
gb_dfm <- dfm(gb_clean_tokens)

# Location of document frequency matrix
dfm_loc <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_documentfrequencymatrix/Bluebook_dfm.csv'

# Convert alternative document frequency matrix to dataframe
gb_dfm_df<- convert(gb_dfm, to = "data.frame")

# Write new document frequency matrix as new csv file for original dfm and modified dfm
write.csv(gb_dfm_df, dfm_loc, row.names = FALSE)

# Run time calculation
end_time <- Sys.time()

# Output run time for 25 text files
run_time <- end_time - start_time
print(run_time)

# ---------------------------------- BEIGEBOOK --------------------------------------

# load in document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_preprocess/Beigebook'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Turn clean texts into corpus
gb_clean_corpus <- corpus(gb_df)

# Tokenize clean corpus
gb_clean_tokens <- tokens(gb_clean_corpus)

# Stem the tokens
gb_clean_tokens <- tokens_wordstem(gb_clean_tokens, language = quanteda_options("language_stemmer"))

# Necessary for memory management
rm(gb_clean_corpus)

# Save file for stemmed version
for (i in 1:length(gb_clean_tokens)){
  print(paste('Processing ', toString(i), ' out of ', toString(length(gb_clean_tokens))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_stemmed/Beigebook'
  clean_filename <- docnames(gb_clean_tokens[i])
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  tokens_txt <- paste(gb_clean_tokens[[i]], collapse = ' ')
  fileConn<-file(filepath_name)
  writeLines(tokens_txt, fileConn)
  close(fileConn)
  i = i + 1
}

# Stemmed directory file path
stemmed_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_stemmed/Beigebook'

# Stemmed dataframe file path
dataframe_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_dataframe/Beigebook.csv'

# Reads text files
stem_df <- readtext(paste0(stemmed_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Write dataframe as csv
write.csv(stem_df, dataframe_directory, row.names = FALSE)

# Turn clean tokens into a document frequency matrix
gb_dfm <- dfm(gb_clean_tokens)

# Location of document frequency matrix
dfm_loc <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_documentfrequencymatrix/Beigebook_dfm.csv'

# Convert alternative document frequency matrix to dataframe
gb_dfm_df<- convert(gb_dfm, to = "data.frame")

# Write new document frequency matrix as new csv file for original dfm and modified dfm
write.csv(gb_dfm_df, dfm_loc, row.names = FALSE)

# Run time calculation
end_time <- Sys.time()

# Output run time for 25 text files
run_time <- end_time - start_time
print(run_time)

# ---------------------------------- TEALBOOK --------------------------------------

# load in document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_preprocess/Tealbook'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Turn clean texts into corpus
gb_clean_corpus <- corpus(gb_df)

# Tokenize clean corpus
gb_clean_tokens <- tokens(gb_clean_corpus)

# Stem the tokens
gb_clean_tokens <- tokens_wordstem(gb_clean_tokens, language = quanteda_options("language_stemmer"))

# Necessary for memory management
rm(gb_clean_corpus)

# Save file for stemmed version
for (i in 1:length(gb_clean_tokens)){
  print(paste('Processing ', toString(i), ' out of ', toString(length(gb_clean_tokens))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_stemmed/Tealbook'
  clean_filename <- docnames(gb_clean_tokens[i])
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  tokens_txt <- paste(gb_clean_tokens[[i]], collapse = ' ')
  fileConn<-file(filepath_name)
  writeLines(tokens_txt, fileConn)
  close(fileConn)
  i = i + 1
}

# Stemmed directory file path
stemmed_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_stemmed/Tealbook'

# Stemmed dataframe file path
dataframe_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_dataframe/Tealbook.csv'

# Reads text files
stem_df <- readtext(paste0(stemmed_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Write dataframe as csv
write.csv(stem_df, dataframe_directory, row.names = FALSE)

# Turn clean tokens into a document frequency matrix
gb_dfm <- dfm(gb_clean_tokens)

# Location of document frequency matrix
dfm_loc <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_documentfrequencymatrix/Tealbook_dfm.csv'

# Convert alternative document frequency matrix to dataframe
gb_dfm_df<- convert(gb_dfm, to = "data.frame")

# Write new document frequency matrix as new csv file for original dfm and modified dfm
write.csv(gb_dfm_df, dfm_loc, row.names = FALSE)

# Run time calculation
end_time <- Sys.time()

# Output run time for 25 text files
run_time <- end_time - start_time
print(run_time)

