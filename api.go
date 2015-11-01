package main

import (
	"github.com/joho/godotenv"
	"github.com/labstack/echo"
	"net/http"
	"radio-paradise"
)

func NowPlaying(c *echo.Context) error {
	return c.JSONP(http.StatusOK, c.Query("callback"), &struct {
		Now    radioparadise.Song   `json:"now"`
		Before []radioparadise.Song `json:"before"`
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

	go radioparadise.StayUpdated()

	e := echo.New()
	e.Static("/", "ui/public")
	e.Get("/api/now", NowPlaying)
	e.Run(":8080")

	//radioparadise.MigrateDB()
}
