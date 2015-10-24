package radioparadise

import (
	"errors"
	"fmt"
	"github.com/PuerkitoBio/goquery"
	"github.com/azer/logger"
	"os"
	"strings"
	"time"
)

func StayUpdated() {
	ticker := time.NewTicker(5 * time.Second)

	for {
		go SaveUpdates()
		<-ticker.C
	}
}

func SaveUpdates() {
	for song := range FindUpdates() {
		DB.Create(&song)
	}
}

func FindUpdates() <-chan Song {
	updates := make(chan Song)
	go SendUpdates(updates)
	return updates
}

func SendUpdates(updates chan Song) {
	saved := RecentSongs()
	remote, err := ReadFromRemote()

	if err != nil {
		log.Error("Can not read from remote.", logger.Attrs{
			"error": err,
		})
	}

	for i, r := range remote {
		if r.Artist == saved[i].Artist && r.Title == saved[i].Title {
			break
		}

		log.Info("Publishing an update", logger.Attrs{
			"artist": r.Artist,
			"title":  r.Title,
		})

		updates <- r
	}

	close(updates)
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
