# ---------------------------------- TITLE -------------------------------------
# 03_LDAproj_cleantextfiles.R
# AUTHOR: HARUKA TAKAGI
# DATE: JULY 12, 2020
# ENCODING: utf-8
# PYTHON VERSION: 3.7

# ---------------------------------- NOTES -------------------------------------
# The purpose of this script is to take the FOMC text files and make them cleaner.
# Remove spaces over two character lengths long, remove numbers, punctuation,
# and new line characters. Output text files will not keep any formatting
# elements. 

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
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_removedtables/Greenbook_mini'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Remove all newline characters from the text
i = 1
for(i in 1:nrow(gb_df)){
  print(paste('Processing: ', as.String(i), ' out of ', as.String(nrow(gb_df))))
  gb_df$text[i] <- gsub('\n', ' ', gb_df$text[i], ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
  gb_df$text[i] <- gsub('\f', ' ', gb_df$text[i], ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
  i = i + 1
}

# Turn into gb_df into a corpus
gb_corpus <- corpus(gb_df)

# Tokenize corpus, remove punctuation, symbols, months, roman numerals and bullet numbers.
gb_tokens <- tokens(gb_corpus, split_hyphens = TRUE, remove_punct = TRUE, remove_symbols = TRUE, remove_numbers = TRUE, padding = FALSE)

# NECESSARY FOR MEMORY MANAGEMENT
rm(gb_corpus)

# Remove roman numerals
gb_tokens <- tokens_select(gb_tokens, pattern = c('II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'), selection = 'remove', case_insensitive = TRUE, padding = FALSE)

# convert tokens to all lowercase
gb_tokens <- tokens_tolower(gb_tokens)

# Remove words with length of two and stopwords
gb_tokens <- tokens_select(gb_tokens, min_nchar = 3, selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = stopwords('en'), selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = c('*1*', '*2*', '*3*', '*4*', '*5*', '*6*', '*7*', '*8*', '*9*', '*0*'), selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = c('jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sept', 'nov', 'dec', 'january', 'feburary', 'march', 'april', 'june', 'july', 'september', 'october', 'august', 'november', 'december'), selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = c('.u'), selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = c('*.*'), selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = c('www.*'), selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = c('month', 'months', 'quarter', 'quarters', 'year', 'years', 'date', 'dates', 'annual'), selection = 'remove', padding = FALSE)
# REMOVE MORE WORDS

# Save file for clean version
for (i in 1:length(gb_tokens)){
  print(paste('Processing ', toString(i), ' out of ', toString(length(gb_tokens))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_cleaned/Greenbook_mini'
  clean_filename <- docnames(gb_tokens[i])
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  tokens_txt <- paste(gb_tokens[[i]], collapse = ' ')
  fileConn<-file(filepath_name)
  writeLines(tokens_txt, fileConn)
  close(fileConn)
  i = i + 1
}

# Run time calculation
end_time <- Sys.time()

# Output run time for 25 text files
run_time <- end_time - start_time
print(run_time)


# ---------------------------------- GREENBOOK --------------------------------------

# load in Greenbook document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_removedtables/Greenbook'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Remove all newline characters from the text
i = 1
for(i in 1:nrow(gb_df)){
  print(paste('Processing: ', as.String(i), ' out of ', as.String(nrow(gb_df))))
  gb_df$text[i] <- gsub('\n', ' ', gb_df$text[i], ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
  gb_df$text[i] <- gsub('\f', ' ', gb_df$text[i], ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
  i = i + 1
}

# Turn into gb_df into a corpus
gb_corpus <- corpus(gb_df)

# Tokenize corpus, remove punctuation, symbols, months, roman numerals and bullet numbers.
gb_tokens <- tokens(gb_corpus, split_hyphens = TRUE, remove_punct = TRUE, remove_symbols = TRUE, remove_numbers = TRUE, padding = FALSE)

# NECESSARY FOR MEMORY MANAGEMENT
rm(gb_corpus)

# Remove roman numerals
gb_tokens <- tokens_select(gb_tokens, pattern = c('II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'), selection = 'remove', case_insensitive = TRUE, padding = FALSE)

# convert tokens to all lowercase
gb_tokens <- tokens_tolower(gb_tokens)

# Remove words with length of two and stopwords
gb_tokens <- tokens_select(gb_tokens, min_nchar = 3, selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = stopwords('en'), selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = c('*1*', '*2*', '*3*', '*4*', '*5*', '*6*', '*7*', '*8*', '*9*', '*0*'), selection = 'remove', padding = FALSE)
# REMOVE MORE WORDS

# Save file for clean version
for (i in 1:length(gb_tokens)){
  print(paste('Processing ', toString(i), ' out of ', toString(length(gb_tokens))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_cleaned/Greenbook'
  clean_filename <- docnames(gb_tokens[i])
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  tokens_txt <- paste(gb_tokens[[i]], collapse = ' ')
  fileConn<-file(filepath_name)
  writeLines(tokens_txt, fileConn)
  close(fileConn)
  i = i + 1
}

# Run time calculation
end_time <- Sys.time()

# Output run time for 25 text files
run_time <- end_time - start_time
print(run_time)

# ---------------------------------- BLUEBOOK --------------------------------------

# load in Greenbook document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_removedtables/Bluebook'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Remove all newline characters from the text
i = 1
for(i in 1:nrow(gb_df)){
  print(paste('Processing: ', as.String(i), ' out of ', as.String(nrow(gb_df))))
  gb_df$text[i] <- gsub('\n', ' ', gb_df$text[i], ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
  gb_df$text[i] <- gsub('\f', ' ', gb_df$text[i], ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
  i = i + 1
}

# Turn into gb_df into a corpus
gb_corpus <- corpus(gb_df)

# Tokenize corpus, remove punctuation, symbols, months, roman numerals and bullet numbers.
gb_tokens <- tokens(gb_corpus, split_hyphens = TRUE, remove_punct = TRUE, remove_symbols = TRUE, remove_numbers = TRUE, padding = FALSE)

# NECESSARY FOR MEMORY MANAGEMENT
rm(gb_corpus)

# Remove roman numerals
gb_tokens <- tokens_select(gb_tokens, pattern = c('II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'), selection = 'remove', case_insensitive = TRUE, padding = FALSE)

# convert tokens to all lowercase
gb_tokens <- tokens_tolower(gb_tokens)

# Remove words with length of two and stopwords
gb_tokens <- tokens_select(gb_tokens, min_nchar = 3, selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = stopwords('en'), selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = c('*1*', '*2*', '*3*', '*4*', '*5*', '*6*', '*7*', '*8*', '*9*', '*0*'), selection = 'remove', padding = FALSE)
# REMOVE MORE WORDS

# Save file for clean version
for (i in 1:length(gb_tokens)){
  print(paste('Processing ', toString(i), ' out of ', toString(length(gb_tokens))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_cleaned/Bluebook'
  clean_filename <- docnames(gb_tokens[i])
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  tokens_txt <- paste(gb_tokens[[i]], collapse = ' ')
  fileConn<-file(filepath_name)
  writeLines(tokens_txt, fileConn)
  close(fileConn)
  i = i + 1
}

# Run time calculation
end_time <- Sys.time()

# Output run time for 25 text files
run_time <- end_time - start_time
print(run_time)


# ---------------------------------- BEIGEBOOK --------------------------------------

# load in Greenbook document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_removedtables/Beigebook'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Remove all newline characters from the text
i = 1
for(i in 1:nrow(gb_df)){
  print(paste('Processing: ', as.String(i), ' out of ', as.String(nrow(gb_df))))
  gb_df$text[i] <- gsub('\n', ' ', gb_df$text[i], ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
  gb_df$text[i] <- gsub('\f', ' ', gb_df$text[i], ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
  i = i + 1
}

# Turn into gb_df into a corpus
gb_corpus <- corpus(gb_df)

# Tokenize corpus, remove punctuation, symbols, months, roman numerals and bullet numbers.
gb_tokens <- tokens(gb_corpus, split_hyphens = TRUE, remove_punct = TRUE, remove_symbols = TRUE, remove_numbers = TRUE, padding = FALSE)

# NECESSARY FOR MEMORY MANAGEMENT
rm(gb_corpus)

# Remove roman numerals
gb_tokens <- tokens_select(gb_tokens, pattern = c('II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'), selection = 'remove', case_insensitive = TRUE, padding = FALSE)

# convert tokens to all lowercase
gb_tokens <- tokens_tolower(gb_tokens)

# Remove words with length of two and stopwords
gb_tokens <- tokens_select(gb_tokens, min_nchar = 3, selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = stopwords('en'), selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = c('*1*', '*2*', '*3*', '*4*', '*5*', '*6*', '*7*', '*8*', '*9*', '*0*'), selection = 'remove', padding = FALSE)
# REMOVE MORE WORDS

# Save file for clean version
for (i in 1:length(gb_tokens)){
  print(paste('Processing ', toString(i), ' out of ', toString(length(gb_tokens))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_cleaned/Beigebook'
  clean_filename <- docnames(gb_tokens[i])
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  tokens_txt <- paste(gb_tokens[[i]], collapse = ' ')
  fileConn<-file(filepath_name)
  writeLines(tokens_txt, fileConn)
  close(fileConn)
  i = i + 1
}

# Run time calculation
end_time <- Sys.time()

# Output run time for 25 text files
run_time <- end_time - start_time
print(run_time)


# ---------------------------------- TEALBOOK --------------------------------------

# load in Greenbook document directory
gb_directory <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_removedtables/Tealbook'

# Reads text files
gb_df<- readtext(paste0(gb_directory, "/*"), encoding = 'utf-8', docvarnames = c('year', 'filename'), dvsep = "/")

# Remove all newline characters from the text
i = 1
for(i in 1:nrow(gb_df)){
  print(paste('Processing: ', as.String(i), ' out of ', as.String(nrow(gb_df))))
  gb_df$text[i] <- gsub('\n', ' ', gb_df$text[i], ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
  gb_df$text[i] <- gsub('\f', ' ', gb_df$text[i], ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
  i = i + 1
}

# Turn into gb_df into a corpus
gb_corpus <- corpus(gb_df)

# Tokenize corpus, remove punctuation, symbols, months, roman numerals and bullet numbers.
gb_tokens <- tokens(gb_corpus, split_hyphens = TRUE, remove_punct = TRUE, remove_symbols = TRUE, remove_numbers = TRUE, padding = FALSE)

# NECESSARY FOR MEMORY MANAGEMENT
rm(gb_corpus)

# Remove roman numerals
gb_tokens <- tokens_select(gb_tokens, pattern = c('II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'), selection = 'remove', case_insensitive = TRUE, padding = FALSE)

# convert tokens to all lowercase
gb_tokens <- tokens_tolower(gb_tokens)

# Remove words with length of two and stopwords
gb_tokens <- tokens_select(gb_tokens, min_nchar = 3, selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = stopwords('en'), selection = 'remove', padding = FALSE)
gb_tokens <- tokens_select(gb_tokens, pattern = c('*1*', '*2*', '*3*', '*4*', '*5*', '*6*', '*7*', '*8*', '*9*', '*0*'), selection = 'remove', padding = FALSE)
# REMOVE MORE WORDS

# Save file for clean version
for (i in 1:length(gb_tokens)){
  print(paste('Processing ', toString(i), ' out of ', toString(length(gb_tokens))))
  directory_string <- '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_cleaned/Tealbook'
  clean_filename <- docnames(gb_tokens[i])
  year <- substr(clean_filename, 5, 8)
  filepath_name <- substr(paste(directory_string, year,clean_filename, sep = '/'), 1, 255)
  tokens_txt <- paste(gb_tokens[[i]], collapse = ' ')
  fileConn<-file(filepath_name)
  writeLines(tokens_txt, fileConn)
  close(fileConn)
  i = i + 1
}

# Run time calculation
end_time <- Sys.time()

# Output run time for 25 text files
run_time <- end_time - start_time
print(run_time)

