tell application "Music"
  if exists (artwork 1 of current track) then
    set srcBytes to (get raw data of artwork 1 of current track)
  else
    return -- Exit if no artwork
  end if
end tell

set fileName to ((path to home folder) as string ) & "album_art.tiff"
set outFile to (open for access file fileName with write permission)
try
  set eof outFile to 0
  write srcBytes to outFile
  close access outFile
on error
  close access outfile
end try
