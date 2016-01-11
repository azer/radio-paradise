package radioparadise

import (
	"github.com/azer/crud"
	_ "github.com/go-sql-driver/mysql"
	"os"
)

var DB *crud.DB

func OpenDB() error {
	var err error
	DB, err = crud.Connect("mysql", os.Getenv("DATABASE_URL"))
	return err
}

func MigrateDB() {
	//DB.DropTables(Song{})
	DB.CreateTables(Song{})
}
