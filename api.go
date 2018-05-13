package main

import (
	"github.com/azer/logger"
	"github.com/joho/godotenv"
	"github.com/labstack/echo"
	"net/http"
	"os"
	"radio-paradise"
)

var log = logger.New("radio-paradise")

func NowPlaying(c echo.Context) error {
	recent, err := radioparadise.RecentSongs()
	if err != nil {
		log.Error("Failed to get recent songs", logger.Attrs{
			"error": err,
		})
		return err
	}

	popular, err := radioparadise.Popular()
	if err != nil {
		log.Error("Failed to get popular songs", logger.Attrs{
			"error": err,
		})
		return err
	}

	return c.JSON(http.StatusOK, &struct {
		NowPlaying []*radioparadise.Song `json:"nowplaying"`
		Popular    []*radioparadise.Song `json:"popular"`
	}{
		NowPlaying: recent,
		Popular:    popular,
	})
}

func main() {
	if err := godotenv.Load(); err != nil {
		panic(err)
	}

	if err := radioparadise.OpenDB(); err != nil {
		panic(err)
	}

	radioparadise.MigrateDB()

	go radioparadise.StayUpdated()

	e := echo.New()
	e.Static("/", "ui/public")
	e.GET("/api/now", NowPlaying)
	e.Start(os.Getenv("ADDR"))
}
