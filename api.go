package main

import (
	"github.com/azer/atlas"
	"github.com/azer/radio-paradise-api/radio-paradise"
	"github.com/joho/godotenv"
)

func NowPlaying(request *atlas.Request) *atlas.Response {
	return atlas.Success(struct {
		Now    radioparadise.Song
		Before []radioparadise.Song
	}{
		radioparadise.CurrentPlayingSong(),
		radioparadise.LastThreeSongs(),
	})
}

func main() {
	if err := godotenv.Load(); err != nil {
		panic(err)
	}

	if err := radioparadise.OpenDB(); err != nil {
		panic(err)
	}

	api := atlas.New(atlas.Map{
		"/now": NowPlaying,
	})

	go radioparadise.StayUpdated()

	api.Start(":8080")

	//radioparadise.MigrateDB()
}
