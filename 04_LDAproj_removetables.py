# ---------------------------------- TITLE -------------------------------------
# 02.5_LDAproj_removetables.py
# AUTHOR: HARUKA TAKAGI
# DATE: JULY 11, 2020
# ENCODING: utf-8
# PYTHON VERSION: 3.7

# ---------------------------------- NOTES -------------------------------------
# The purpose of this script is to take the FOMC_Historical_Materials_textfiles.py
# and remove tables from the text files.

# ---------------------------------- SETUP -------------------------------------
from io import StringIO
import os
import nltk
from nltk.corpus import stopwords

# ---------------------------------- CODE --------------------------------------

# load in stopwords from nltk
stopwords = set(stopwords.words('english'))

# add words to nltk stopwords set
stopwords.add('confidential')
stopwords.add('note')
stopwords.add('developments')
stopwords.add('using')
stopwords.add('strong')
stopwords.add('class')
stopwords.add('fomc')
stopwords.add('strictly')
stopwords.remove('i')
stopwords.remove('y')
stopwords.remove('ll')
stopwords.remove('a')
stopwords.remove('d')
stopwords.remove('s')
stopwords.remove('t')
stopwords.remove('o')
stopwords.remove('m')
stopwords.remove('of')
stopwords.remove('other')
line_threshold = 50

# ---------------------------------- GREENBOOK_MINI --------------------------------------

# Greenbook_mini
main_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_textfiles/Greenbook_mini'
output_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_removedtables/Greenbook_mini/'

# parse through all files in the greenbook_mini
for subdir, dirs, files in os.walk(main_directory):
    for file in files:
        if file.startswith('.'):
            continue
        file_path = os.path.join(subdir, file)
        year_str = subdir[-4:]
        output_path = output_directory + year_str + '/' + file
        sub_output_path = output_path[:-4]
        final_output_path = sub_output_path + '.txt'
        new_textfile = open(final_output_path, "w+")
        print(file_path)
        with open(file_path, 'r') as in_file:
            text = in_file.readlines()
            for i in range(len(text)):
                current_line = text[i]
                len_text = len(text[i])
                current_line_split = current_line.split()
                tracker = []
                for j in range(len(current_line_split)):
                    word = current_line_split[j].lower()
                    if word in stopwords:
                        tracker = tracker + [True]
                    else:
                        tracker = tracker + [False]
                if (True not in tracker) and (len_text <= line_threshold):
                    x = 1
                else:
                    # print(len_text)
                    # print(tracker)
                    # print(current_line)
                    new_textfile.write(current_line)

print('DONE')

# ---------------------------------- GREENBOOK --------------------------------------

# Greenbook
main_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_textfiles/Greenbook'
output_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_removedtables/Greenbook/'

# parse through all files in the greenbook_mini
for subdir, dirs, files in os.walk(main_directory):
    for file in files:
        if file.startswith('.'):
            continue
        file_path = os.path.join(subdir, file)
        year_str = subdir[-4:]
        output_path = output_directory + year_str + '/' + file
        sub_output_path = output_path[:-4]
        final_output_path = sub_output_path + '.txt'
        new_textfile = open(final_output_path, "w+")
        print(file_path)
        with open(file_path, 'r') as in_file:
            text = in_file.readlines()
            for i in range(len(text)):
                current_line = text[i]
                len_text = len(text[i])
                current_line_split = current_line.split()
                tracker = []
                for j in range(len(current_line_split)):
                    word = current_line_split[j].lower()
                    if word in stopwords:
                        tracker = tracker + [True]
                    else:
                        tracker = tracker + [False]
                if (True not in tracker) and (len_text <= line_threshold):
                    x = 1
                else:
                    # print(len_text)
                    # print(tracker)
                    # print(current_line)
                    new_textfile.write(current_line)

print('DONE')

# ---------------------------------- BLUEBOOK --------------------------------------

# Bluebook
main_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_textfiles/Bluebook'
output_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_removedtables/Bluebook/'

# parse through all files in the greenbook_mini
for subdir, dirs, files in os.walk(main_directory):
    for file in files:
        if file.startswith('.'):
            continue
        file_path = os.path.join(subdir, file)
        year_str = subdir[-4:]
        output_path = output_directory + year_str + '/' + file
        sub_output_path = output_path[:-4]
        final_output_path = sub_output_path + '.txt'
        new_textfile = open(final_output_path, "w+")
        print(file_path)
        with open(file_path, 'r') as in_file:
            text = in_file.readlines()
            for i in range(len(text)):
                current_line = text[i]
                len_text = len(text[i])
                current_line_split = current_line.split()
                tracker = []
                for j in range(len(current_line_split)):
                    word = current_line_split[j].lower()
                    if word in stopwords:
                        tracker = tracker + [True]
                    else:
                        tracker = tracker + [False]
                if (True not in tracker) and (len_text <= line_threshold):
                    x = 1
                else:
                    # print(len_text)
                    # print(tracker)
                    # print(current_line)
                    new_textfile.write(current_line)

print('DONE')

# ---------------------------------- TEALBOOK --------------------------------------

# Tealbook
main_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_textfiles/Tealbook'
output_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_removedtables/Tealbook/'

# parse through all files in the greenbook_mini
for subdir, dirs, files in os.walk(main_directory):
    for file in files:
        if file.startswith('.'):
            continue
        file_path = os.path.join(subdir, file)
        year_str = subdir[-4:]
        output_path = output_directory + year_str + '/' + file
        sub_output_path = output_path[:-4]
        final_output_path = sub_output_path + '.txt'
        new_textfile = open(final_output_path, "w+")
        print(file_path)
        with open(file_path, 'r') as in_file:
            text = in_file.readlines()
            for i in range(len(text)):
                current_line = text[i]
                len_text = len(text[i])
                current_line_split = current_line.split()
                tracker = []
                for j in range(len(current_line_split)):
                    word = current_line_split[j].lower()
                    if word in stopwords:
                        tracker = tracker + [True]
                    else:
                        tracker = tracker + [False]
                if (True not in tracker) and (len_text <= line_threshold):
                    x = 1
                else:
                    # print(len_text)
                    # print(tracker)
                    # print(current_line)
                    new_textfile.write(current_line)

print('DONE')

# ---------------------------------- BEIGEBOOK --------------------------------------

# Beigebook
main_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_textfiles/Beigebook'
output_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_text/FOMC_Historical_Materials_removedtables/Beigebook/'

# parse through all files in the greenbook_mini
for subdir, dirs, files in os.walk(main_directory):
    for file in files:
        if file.startswith('.'):
            continue
        file_path = os.path.join(subdir, file)
        year_str = subdir[-4:]
        output_path = output_directory + year_str + '/' + file
        sub_output_path = output_path[:-4]
        final_output_path = sub_output_path + '.txt'
        new_textfile = open(final_output_path, "w+")
        print(file_path)
        with open(file_path, 'r') as in_file:
            text = in_file.readlines()
            for i in range(len(text)):
                current_line = text[i]
                len_text = len(text[i])
                current_line_split = current_line.split()
                tracker = []
                for j in range(len(current_line_split)):
                    word = current_line_split[j].lower()
                    if word in stopwords:
                        tracker = tracker + [True]
                    else:
                        tracker = tracker + [False]
                if (True not in tracker) and (len_text <= line_threshold):
                    x = 1
                else:
                    # print(len_text)
                    # print(tracker)
                    # print(current_line)
                    new_textfile.write(current_line)

print('DONE')
