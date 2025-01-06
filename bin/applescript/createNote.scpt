on createNote(noteName, folderName, initialContent)
    tell application "Notes"
        set theFolder to folder folderName
        make new note at theFolder with properties {name:noteName, body:initialContent}
    end tell
end createNote
