import Data.ByteString.Lazy (intercalate)
--Function of type Io(Char, Char, Char, Char)
--Read 4 letters separated by enter and return as a sequence

read4Letters :: IO (Char, Char, Char, Char)
read4Letters = do
    a <- getChar
    getLine
    b <- getChar
    getLine
    c <- getChar
    getLine
    d <- getChar
    getLine
    return (a, b, c, d)

--Function that takes the sequence from precedent function and returns a string of it
charsToString :: (Char, Char, Char, Char) -> String
charsToString (a,b,c,d) = [a,b,c,d] --Since String is an alias for [Char]


--Main function
--Uses that string and some files names
--Print the content of the file name
--Replace the 4th line if it exist with the string
--If succeed, print the new content of the file
--If failed gives the messages "File is too short"
main = do
    putStrLn "Please enter 4 characters seperated by ENTER"
    x <- read4Letters
    let my_line = charsToString x
    putStrLn "Please enter a name file (with the extension)"
    --let file = "test_long.txt"
    file <- getLine
    file_content <- readFile file
    let file_lines = lines file_content
    putStrLn "Current content of the file :"
    mapM_ putStrLn file_lines
    putStrLn ("Trying to replace the 4th line with " ++ show my_line ++ "...")
    let len_lines = length file_lines
    if len_lines < 4
        then putStrLn "The file is too short !"
        else do
            let (begin,_:end) = splitAt 3 file_lines
            --Now we have 2 list of lines : begin is lines 1 to 3 and end is lines 5 to end
            -- The line 4 is deleted and we will replace it with our line
            let new_content = begin ++ my_line : end
            mapM_ putStrLn new_content
            writeFile file (unlines new_content)
            putStrLn "File modified !"
