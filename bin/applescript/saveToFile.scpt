on saveToFile(content, outputFilePath)
    -- Escape the content for shell usage
    set escapedContent to do shell script "printf %s " & quoted form of content
    -- Write to the specified file path
    do shell script "echo " & quoted form of escapedContent & " > " & quoted form of outputFilePath
end saveToFile
