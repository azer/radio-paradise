package radioparadise

func CurrentPlayingSong() Song {
	var song Song
	DB.Order("played_at desc").First(&song)
	return song
}

func RecentSongs() []Song {
	var songs []Song
	DB.Limit(4).Order("played_at desc").Find(&songs)
	return songs
}
