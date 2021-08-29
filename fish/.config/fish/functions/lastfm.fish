function lastfm --argument-names song_or_artist --description "LastFM history search"

  set -q RECENTTRACKS || set RECENTTRACKS "/Users/$USER/Downloads/recenttracks.csv"

  if not test -f "$RECENTTRACKS"
    echo "Tracks $RECENTTRACKS file does not exist yet."
    echo 'Perhaps download new file? https://lastfm.ghan.nl/export/'
    return 1
  end

  if not type -q xsv
    echo '"xsv" is not installed'
    return 1
  end

  xsv search -i "$argv" "$RECENTTRACKS" | xsv select utc_time,artist,track,album | xsv table
end
