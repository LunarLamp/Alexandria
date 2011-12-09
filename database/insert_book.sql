SET autocommit=0;
START TRANSACTION
SELECT COUNT(*) FROM tblAuthor where AuthorName = "Edward Hargin";
/* if count > 0... */
INSERT INTO tblAuthor (AuthorID,AuthorName) VALUES (NULL,"Edward Hargin");
INSERT INTO tblBook (BookID,BookAuthorID,BookTitle,BookISBN,BookFormat,BookPubDate)
	VALUES (NULL,LAST_INSERT_ID(),'My First Transaction',978101101,1,2011);
COMMIT;
