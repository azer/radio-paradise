package radioparadise

import (
	"time"
)

const CACHE_INVALIDATION_THRESHOLD = 360

var (
	cached       []*Song
	lastCachedAt int64
)

func Popular() ([]*Song, error) {
	if time.Now().Unix()-lastCachedAt < CACHE_INVALIDATION_THRESHOLD {
		log.Info("Returning popular songs from cache")
		return cached, nil
	}

	log.Info("Pulling popular songs from DB")

	songs := []*Song{}
	err := DB.Read(&songs, `SELECT artist, title, COUNT(*) as play_count
                                FROM song
                                WHERE played_at >= DATE(NOW()) - INTERVAL 14 DAY
                                GROUP BY artist, title
                                ORDER BY play_count DESC
                                LIMIT 25`)

	if err == nil {
		cached = songs
		lastCachedAt = time.Now().Unix()
	}

	return songs, err
}
