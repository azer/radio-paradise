package radioparadise

import (
	"database/sql"
	"errors"
	"fmt"
	"github.com/PuerkitoBio/goquery"
	"github.com/azer/logger"
	"os"
	"strings"
	"time"
)

var lock bool

func StayUpdated() {
	ticker := time.NewTicker(3 * time.Second)

	for {
		if !lock {
			go CheckForUpdates()
		}

		<-ticker.C
	}
}

func CheckForUpdates() {
	lock = true
	timer := log.Timer()

	remoteLastSong, err := ReadLastSongFromRemote()

	if err != nil {
		log.Error("Can not check for updates. ", logger.Attrs{
			"error": err,
		})
		lock = false
		return
	}

	savedLastSong, err := CurrentPlayingSong()
	if err != nil && err != sql.ErrNoRows {
		log.Error("Can not get currently playing song.", logger.Attrs{
			"error": err,
		})
		lock = false
		return
	}

	if savedLastSong == nil || !remoteLastSong.IsSameWith(savedLastSong) {
		log.Info("Saving new song", logger.Attrs{
			"artist": remoteLastSong.Artist,
			"title":  remoteLastSong.Title,
		})

		DB.Create(&remoteLastSong)
	}

	timer.End("Checked for updates")
	lock = false
}

func ReadLastSongFromRemote() (Song, error) {
	songs, err := ReadFromRemote()

	if err != nil {
		return Song{}, err
	}

	if len(songs) == 0 {
		return Song{}, errors.New("Can not find any songs")
	}

	return songs[0], nil
}

func ReadFromRemote() ([]Song, error) {
	var (
		result []Song = []Song{}
		doc    *goquery.Document
		err    error
	)

	if doc, err = goquery.NewDocument(os.Getenv("SOURCE_URL")); err != nil {
		return nil, err
	}

	doc.Find(".song_title").Each(func(i int, s *goquery.Selection) {
		if song, err := ParseSourceRow(s.Text()); err == nil {
			result = append(result, song)
		}
	})

	for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
		result[i], result[j] = result[j], result[i]
	}

	return result, nil
}

func ParseSourceRow(row string) (Song, error) {
	song := Song{}

	if len(row) == 0 {
		return song, errors.New("Can not parse empty row")
	}

	parts := strings.Split(row, " — ")

	if len(parts) < 2 {
		return song, errors.New(fmt.Sprintf("Can not parse '%s'", row))
	}

	song.Artist = parts[0]
	song.Title = parts[1]
	song.PlayedAt = time.Now()

	return song, nil
}
