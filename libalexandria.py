#!/usr/bin/python
import sys
import MySQLdb    #Requires python-mysqldb 
import urllib
import lxml.etree
import ConfigParser


debug = 1

config = ConfigParser.RawConfigParser()
config.read('alexandria.conf')

def barcode2isbn(scannedBarcode):
    """
    Function to take a book's barcode (string) and return the
    ISBN of the book (string)
    """
    #A scanned barcode would look like this: A9780571258093
    #The ISBN is just 9780375836671
    #All we need to do is remove the leading 'A'

    isbn = scannedBarcode.lstrip('A')
    return isbn

    #Note, as you may guess from above, this does not yet deal with all possible conversions, just the most simple


def runQuery(query):
    """
    Function to run database queries - requires documenting properly
    """
    dbhost = config.get('alexandria', 'dbhost')
    dbuser = config.get('alexandria', 'dbuser')
    dbpass = config.get('alexandria', 'dbpass')
    dbname = config.get('alexandria', 'dbname')
    try:
        db_conn = MySQLdb.connect ( host = dbhost, user = dbuser, passwd = dbpass, db = dbname )
    except MySQLdb.Error, err:
        print "Error %d: %s" % (err.args[0], err.args[1])
        sys.exit (1)

    cursor = db_conn.cursor ()
    cursor.execute (query)
    result = cursor.fetchone ()     #this may need modification - only allows 1 row in results
    cursor.close ()
    db_conn.close ()
    
    return result

## This is ugly copy and paste code.
def runQueryWrite(query):
    """
    Function to run database queries - requires documenting properly
    """
    dbhost = config.get('alexandria', 'dbhost')
    dbuser = config.get('alexandria', 'dbuser')
    dbpass = config.get('alexandria', 'dbpass')
    dbname = config.get('alexandria', 'dbname')
    try:
        db_conn = MySQLdb.connect ( host = dbhost, user = dbuser, passwd = dbpass, db = dbname )
    except MySQLdb.Error, err:
        print "Error %d: %s" % (err.args[0], err.args[1])
        sys.exit (1)

    cursor = db_conn.cursor ()
    cursor.execute (query)
    db_conn.commit()
    cursor.close ()
    db_conn.close ()
    

def getXML(URL):
    """ 
    Function that downloads xml from a given URL, and then parses it, and
    returns the parsed tree.
    """
    try:
        sock = urllib.urlopen(URL)
    except (IOError, OSError):
        print "failed"
        sys.exit (1)

    tree = lxml.etree.parse(sock)
    return tree


#Function currently unused.
def makebookURL(ISBN,source):
    """
    INPUT: ISBN and name of lookup location
    OUTPUT: URL specific to the book that contains (hopefully) a full set of 
    info about the book
    """
    if "goodreads" in source:
        api_key = config.get('alexandria', 'goodreads_key')
        baseURL = "http://www.goodreads.com/search/index.xml?key=" + api_key + "&q="
    elif "isbndb" in source:
        api_key = config.get('alexandria', 'isbndb_key')
        baseURL = "http://isbndb.com/api/books.xml?access_key=" + api_key + "&index1=isbn&value1="
    else:
        print "Unrecognised source"
        sys.exit(99)
    
    apiURL = baseURL + ISBN
    return apiURL


def addbooktodb(bookauthor,booktitle,bookISBN,bookpubdate):
    if checkbookisindb(bookISBN) == 1:
        print "This book is already in the database!"
        exit #exit function...except, er, it doesn't seem to work.
    #Sort out author first
    else:
        print "This book is not already in the database... so adding it now"

        if debug: print "bookauthor = %s" % (bookauthor)
        if checkauthorisindb(bookauthor) == 1:
            authorid = getauthorid(bookauthor)[0]
        else:
            authorid = addauthortodb(bookauthor)
        
        #Now add the book to the database
        query = 'INSERT INTO tblBook (BookID,BookAuthorID,BookTitle,BookISBN,BookPubDate) VALUES (NULL,%s,"%s",%s,%s);' % (authorid,booktitle,bookISBN,bookpubdate)
        if debug: print query
        runQueryWrite(query)
        print "Book should be added to the database now!"   #but, let's be honest, it really might not have been...


def addauthortodb(author):
    """
    Takes as arguments a string (authorname) and a 1/0 (checkauthor)
    will be performed
    Function returns 0 if no author added to database
    If author has been added the function will return BookAuthorID in the tblBookAuthor for the 
    author just added.  This will be an integer.
    """
    if debug: print "Running addauthortodb"
    query = 'INSERT INTO tblBookAuthor (BookAuthorID,BookAuthorName) VALUES (NULL,"%s");' % (author) 
    if debug: print query
    runQueryWrite(query)
    query = 'SELECT BookAuthorID from tblBookAuthor WHERE BookAuthorName = "%s";' % (author)
    author_id = runQuery(query)
    if debug: print "author_id is %s" % (author_id)
    if debug: print "Author id is % s " %  type(author_id)
    author_id = author_id[0]
    if debug: print "=============="
    if debug: print author_id
    if debug: print type(author_id)
    if debug: print "=============="
    return author_id


def checkbookisindb(ISBN):
    """
    Check to see if a book is already in the database. 
    Takes as input ISBN.
    Returns 1 if book is in database
    Returns 0 if book is not in database.
    """
    query = 'SELECT COUNT(*) FROM tblBook where BookISBN = %s;' % (ISBN) 
    if debug: print query
    num_entries = runQuery(query)
    if debug: print num_entries
    if debug: print type(num_entries)
    num_entries = num_entries[0]
    if debug: print type(num_entries)
    if num_entries > 0:
        #book is in database already
        return 1
    else:
        #book is not already in database
        return 0


def checkauthorisindb(author):
    """
    Check to see if an author is already in the database.
    Takes as input the author's name.
    Returns 1 if author is already in the database.
    Returns 0 if author is not already in the database.
    ISSUE: author's name format could be highly variable in reality and thus
    might need some kind of logic to avoid having different entries for (as example):
            J.R.R Tolkein
            J R R Tolkein
            John Ronald Reuel Tolkien
    """
    query = 'SELECT COUNT(*) FROM tblBookAuthor where BookAuthorName = "%s" ;' % (author) 
    if debug: print query
    num_entries = runQuery(query)
    num_entries = num_entries[0]
    if num_entries > 0:
        #author is in database already
        return 1
    else:
        #author is not already in database
        return 0


def getauthorid(author):
    """
    Get the ID of an author in the database
    BookAuthorID in the table BookAuthorName
    """
    query = 'SELECT BookAuthorID FROM tblBookAuthor WHERE BookAuthorName = "%s";' % (author)  
    authorid = runQuery(query)
    if debug: print "authorid = %s" % (authorid)
    return authorid
    

def downloadimage(ISBN,url):
    """
    Downloads the image located at the given URL, and stores it in a filename
    of ISBN.jpg
    Improvements:
        - validate image
        - pick an appropriate extension based on the image type
    """
    

    imagedir = config.get('alexandria', 'image_dir')
    #create filename
    filename = imagedir+str(ISBN)+'.jpg'

    #download and store image 
    urllib.urlretrieve(url,filename)

