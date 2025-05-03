tell application "Music"
  tell artwork 1 of current track
    set srcBytes to data
  end tell
end tell

set fileName to ((path to home folder) as string) & "album_art.tiff"
set outFile to (open for access file fileName with write permission)
set eof outFile to 0
write srcBytes to outFile
close access outFile
