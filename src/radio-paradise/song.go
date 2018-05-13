package radioparadise

import (
	"time"
)

type Song struct {
	Artist   string    `json:"artist"`
	Title    string    `json:"title"`
	PlayedAt time.Time `json:"playedAt"`
}

func (song *Song) IsSameWith(anotherSong *Song) bool {
	return song.Title == anotherSong.Title && song.Artist == anotherSong.Artist
}
