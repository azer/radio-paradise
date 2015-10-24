package radioparadise

import (
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	"os"
)

var DB gorm.DB

func OpenDB() error {
	var err error
	DB, err = gorm.Open("mysql", os.Getenv("DATABASE_URL"))
	return err
}

func MigrateDB() {
	DB.DropTableIfExists(&Song{})
	DB.CreateTable(&Song{})
}
