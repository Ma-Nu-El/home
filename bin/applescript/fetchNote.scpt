on run {noteName, folderName}
    tell application "Notes"
        set theFolder to folder folderName
        set theNote to note noteName of theFolder
        return body of theNote
    end tell
end run
