#!/usr/bin/python
import sys
import ConfigParser
import libalexandria as alex
from xml.etree.ElementTree import ElementTree
# Toggle line below to 1 or 0 to turn on or off debug.
debug = 0

#Get config values
config = ConfigParser.RawConfigParser()
config.read('alexandria.conf')
book_database = config.get('alexandria', 'book_database')

#initialise some variables with None that we will use later
barcode = None
ISBN = None
apiURL = None
root = None
iter = None
pub_year = None
avg_rat = None
title = None
name = None
image_url = None

while 1:
        barcode = raw_input("Scan barcode now\n") 
        ISBN = alex.barcode2isbn(barcode)

        #Create apiURL depending on service
        apiURL = alex.makebookURL(ISBN,book_database)
        #Declare the root of the xml tree
        root = ElementTree(alex.getXML(apiURL))
        iter = root.getiterator()
        #iterate over elements in the xml tree
        if book_database == "goodreads":
            for element in iter:
                if element.tag == "original_publication_year":
                    if element.text:
                        pub_year = element.text
                        print "pub year is: %s" % (pub_year)
                if element.tag == "average_rating":
                    if element.text:
                        avg_rat = element.text
                        print "average rating is: %s" % (avg_rat)
                if element.tag == "title":
                    if element.text:
                        title = element.text
                        print "title is: %s" % (title)
                if element.tag == "name":
                    if element.text:
                        name = element.text
                        print "author is: %s" % (name)
                if element.tag == "image_url":
                    if element.text:
                        image_url = element.text
                        #check if there is an image or not, by looking for string 'nocover' in returned URL
                        if "nocover" not in image_url:
                            if debug: print "The URL cover can be found at: %s" % (image_url)
                            print "Adding cover to collection!"
                            if debug: print "Storing cover locally..."
                            alex.downloadimage(ISBN,image_url)
                            if debug: print "Cover stored locally point in code"
                        else:
                            if debug: print "No cover could be found for this book"
        elif book_database == "isbndb":
            print "Parsing support not yet implemented for isbndb. Please use GoodReads instead."
        else:
            print "Unrecognised value for book_database: %s" % (book_database)

        #debug
        if debug:   print "apiURL = %s" % (apiURL)
        if debug:   print "\n\nISBN = %s \n\n" % (ISBN)
        
        
        #Check that we have values for all variables before inserting into the DB
        #TODO: handle the case where we do not have all of this info!
        if ( name != None ) & ( title != None ) & ( ISBN != None ) & ( pub_year != None ):
            alex.addbooktodb(name,title,ISBN,pub_year)

        print " "
        print " "
        print "============================================"
