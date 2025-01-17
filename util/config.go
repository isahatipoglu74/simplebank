package util

import (
	"github.com/spf13/viper"
)

type Config struct {
	DBDriver      string `mapstructure:"DB_DRIVER"`
	DBSource      string `mapstructure:"DB_SOURCE"`
	ServerAddress string `mapstructure:"SERVER_ADDRESS"`
}

func LoadConfig(path string) (config Config, err error) {
	viper.AddConfigPath(path)  //yapılandırma dosyasının bulunduğu dizini belirtir.
	viper.SetConfigName("app") //Yapılandırma dosyasının adını belirtir (örneğin, app.env).
	viper.SetConfigType("env") //Yapılandırma dosyasının türünü belirtir (bu örnekte, .env uzantılı bir dosya).

	viper.AutomaticEnv() //Ortam değişkenlerini otomatik olarak okur ve yapılandırma değerlerine atar.

	err = viper.ReadInConfig() //Yapılandırma dosyasını okur. Eğer hata oluşursa, hata döndürülür.
	if err != nil {
		return
	}

	err = viper.Unmarshal(&config) //Okunan yapılandırma değerlerini Config yapısına ayrıştırır. Ayrıştırma başarılı olmazsa, hata döndürülür.
	return
}
