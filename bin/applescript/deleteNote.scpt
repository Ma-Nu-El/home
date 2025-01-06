on deleteNote(noteName, folderName)
    tell application "Notes"
        set theFolder to folder folderName
        delete (note noteName of theFolder)
    end tell
end deleteNote
