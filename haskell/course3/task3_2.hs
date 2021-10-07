--Add a record for a book
--Book name, Author name, ISBN number, Year of publishing and Version Number

data ISBN = ISBN Int Int Int Int deriving(Show)

data BookRecord = BookRecord{
    title :: String,
    author_name :: String,
    isbn :: ISBN,
    publishing_year :: Int,
    version :: Int
}deriving(Show)

main=do
    let myFirstBook = BookRecord "Mermaids and cows" "A. Smith" (ISBN 4 1852 1547 36) 2015 3
    print myFirstBook