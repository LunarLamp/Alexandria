#!/bin/bash
echo "WARNING: THIS IS A DODGY SCRIPT THAT WILL DELETE ALL KINDS OF STUFF"
echo "Enter mysql root password:"
read -s password

for table in tblBook tblBookAuthor tblBookCover tblHeader 
do
    mysql -uroot -p"$password" Alexandria -e "truncate $table"
done

for file in images/*
do
    [[ -f "$file" ]] && rm "$file"
done
