 # ---------------------------------- TITLE -------------------------------------
# 02_LDAproj_textconvert.py
# AUTHOR: HARUKA TAKAGI
# DATE: JULY 11, 2020
# ENCODING: utf-8
# PYTHON VERSION: 3.7

# ---------------------------------- NOTES -------------------------------------
# The purpose of this script is to take the FOMC pdf files and convert them to
# text files for easier access and pre-processing.

# ---------------------------------- SETUP -------------------------------------
from io import StringIO
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfdocument import PDFDocument
from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.pdfpage import PDFPage
from pdfminer.pdfparser import PDFParser
import os

# ---------------------------------- CODE --------------------------------------

# Greenbook
main_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_PDF/Greenbook'
output_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_textfiles/Greenbook/'

for subdir, dirs, files in os.walk(main_directory):
    for file in files:
        if file.startswith('.'):
            continue
        file_path = os.path.join(subdir, file)
        year_str = subdir[-4:]
        output_path = output_directory + year_str + '/' + file
        sub_output_path = output_path[:-4]
        final_output_path = sub_output_path + '.txt'
        print(final_output_path)

        output_string = StringIO()
        with open(file_path, 'rb') as in_file:
            parser = PDFParser(in_file)
            doc = PDFDocument(parser)
            rsrcmgr = PDFResourceManager()
            device = TextConverter(rsrcmgr, output_string, laparams=LAParams())
            interpreter = PDFPageInterpreter(rsrcmgr, device)
            for page in PDFPage.create_pages(doc):
                interpreter.process_page(page)

        final_text = output_string.getvalue()

        text_file = open(final_output_path, "w")
        n = text_file.write(final_text)
        text_file.close()


# Bluebook
main_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_PDF/Bluebook'
output_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_textfiles/Bluebook/'

for subdir, dirs, files in os.walk(main_directory):
    for file in files:
        if file.startswith('.'):
            continue
        file_path = os.path.join(subdir, file)
        year_str = subdir[-4:]
        output_path = output_directory + year_str + '/' + file
        sub_output_path = output_path[:-4]
        final_output_path = sub_output_path + '.txt'
        print(final_output_path)

        output_string = StringIO()
        with open(file_path, 'rb') as in_file:
            parser = PDFParser(in_file)
            doc = PDFDocument(parser)
            rsrcmgr = PDFResourceManager()
            device = TextConverter(rsrcmgr, output_string, laparams=LAParams())
            interpreter = PDFPageInterpreter(rsrcmgr, device)
            for page in PDFPage.create_pages(doc):
                interpreter.process_page(page)

        final_text = output_string.getvalue()

        text_file = open(final_output_path, "w")
        n = text_file.write(final_text)
        text_file.close()


# Tealbook
main_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_PDF/Tealbook'
output_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_textfiles/Tealbook/'

for subdir, dirs, files in os.walk(main_directory):
    for file in files:
        if file.startswith('.'):
            continue
        file_path = os.path.join(subdir, file)
        year_str = subdir[-4:]
        output_path = output_directory + year_str + '/' + file
        sub_output_path = output_path[:-4]
        final_output_path = sub_output_path + '.txt'
        print(final_output_path)

        output_string = StringIO()
        with open(file_path, 'rb') as in_file:
            parser = PDFParser(in_file)
            doc = PDFDocument(parser)
            rsrcmgr = PDFResourceManager()
            device = TextConverter(rsrcmgr, output_string, laparams=LAParams())
            interpreter = PDFPageInterpreter(rsrcmgr, device)
            for page in PDFPage.create_pages(doc):
                interpreter.process_page(page)

        final_text = output_string.getvalue()

        text_file = open(final_output_path, "w")
        n = text_file.write(final_text)
        text_file.close()


# Beigebook
main_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_PDF/Beigebook'
output_directory = '/Users/harukatakagi/Dropbox/FOMC_Board/FOMC_Historical_Materials_textfiles/Beigebook/'

for subdir, dirs, files in os.walk(main_directory):
    for file in files:
        if file.startswith('.'):
            continue
        file_path = os.path.join(subdir, file)
        year_str = subdir[-4:]
        output_path = output_directory + year_str + '/' + file
        sub_output_path = output_path[:-4]
        final_output_path = sub_output_path + '.txt'
        print(final_output_path)

        output_string = StringIO()
        with open(file_path, 'rb') as in_file:
            parser = PDFParser(in_file)
            doc = PDFDocument(parser)
            rsrcmgr = PDFResourceManager()
            device = TextConverter(rsrcmgr, output_string, laparams=LAParams())
            interpreter = PDFPageInterpreter(rsrcmgr, device)
            for page in PDFPage.create_pages(doc):
                interpreter.process_page(page)

        final_text = output_string.getvalue()

        text_file = open(final_output_path, "w")
        n = text_file.write(final_text)
        text_file.close()