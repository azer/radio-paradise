package radioparadise

import (
	"time"
)

type Song struct {
	ID       int
	Artist   string    `json:"artist"`
	Title    string    `json:"title"`
	PlayedAt time.Time `json:"playedAt"`
}
