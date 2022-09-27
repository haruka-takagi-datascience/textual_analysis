# ---------------------------------- TITLE -------------------------------------
# 01_LDAproj_pdfconvert.py
# AUTHOR: HARUKA TAKAGI
# DATE: JULY 11, 2020
# ENCODING: utf-8
# PYTHON VERSION: 3.7

# ---------------------------------- NOTES -------------------------------------
# The purpose of this script is to take the FOMC_PDF_Historical_Materials_Links
# and turn the links into files of pdf's per column. For example, running this
# script will generate a 'green book' folder of pdf files.

# ---------------------------------- SETUP -------------------------------------
import requests
import pandas as pd

# ---------------------------------- CODE --------------------------------------

start_url = 'https://www.federalreserve.gov'
link_csv = '/Users/harukatakagi/Dropbox/FOMC_Board/Data/FOMC_PDF_Historical_Materials_Links.csv'

links_df = pd.read_csv(link_csv)

# Green book
directory_greenbook = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_HistoricalMaterials/Greenbook/'

i = 0
for i in range(len(links_df)):
    print('Processing ' + str(i) + ' out of ' + str(len(links_df)))
    if type(links_df['green book'][i]) == str:
        end_url = links_df['green book'][i]
        full_url = start_url + end_url
        year = (str(links_df['year'][i]))
        pdf_dir = directory_greenbook + year + '/' + end_url[22:]
        print(full_url)
        print(pdf_dir)
        response = requests.get(full_url)
        with open(pdf_dir, 'wb') as f:
            f.write(response.content)
    i = i + 1

# Blue book
directory_bluebook = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_HistoricalMaterials/Bluebook/'

i = 0
for i in range(len(links_df)):
    print('Processing ' + str(i) + ' out of ' + str(len(links_df)))
    if type(links_df['blue book'][i]) == str:
        end_url = links_df['blue book'][i]
        full_url = start_url + end_url
        year = (str(links_df['year'][i]))
        pdf_dir = directory_bluebook + year + '/' + end_url[32:]
        print(full_url)
        print(pdf_dir)
        response = requests.get(full_url)
        with open(pdf_dir, 'wb') as f:
            f.write(response.content)
    i = i + 1

# Teal book
directory_tealbook = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_HistoricalMaterials/Tealbook/'

i = 0
for i in range(len(links_df)):
    print('Processing ' + str(i) + ' out of ' + str(len(links_df)))
    if type(links_df['teal book'][i]) == str:
        end_url = links_df['teal book'][i]
        full_url = start_url + end_url
        year = (str(links_df['year'][i]))
        pdf_dir = directory_tealbook + year + '/' + end_url[32:]
        print(full_url)
        print(pdf_dir)
        response = requests.get(full_url)
        with open(pdf_dir, 'wb') as f:
            f.write(response.content)
    i = i + 1

# Beige book
directory_beigebook = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_HistoricalMaterials/Beigebook/'

i = 0
for i in range(len(links_df)):
    print('Processing ' + str(i) + ' out of ' + str(len(links_df)))
    if type(links_df['beige book'][i]) == str:
        end_url = links_df['beige book'][i]
        full_url = start_url + end_url
        year = (str(links_df['year'][i]))
        pdf_dir = directory_beigebook + year + '/' + end_url[32:]
        print(full_url)
        print(pdf_dir)
        response = requests.get(full_url)
        with open(pdf_dir, 'wb') as f:
            f.write(response.content)
    i = i + 1