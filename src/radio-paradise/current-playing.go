package radioparadise

func CurrentPlayingSong() (*Song, error) {
	song := &Song{}
	err := DB.Read(song, "ORDER BY played_at DESC")
	if err != nil {
		return nil, err
	}

	return song, err
}

func RecentSongs() ([]*Song, error) {
	songs := []*Song{}
	err := DB.Read(&songs, "ORDER BY played_at DESC LIMIT 4")
	return songs, err
}
