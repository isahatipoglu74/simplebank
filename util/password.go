package util

import (
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

// şifreyi alır ve bcrypte hash dizesi oluşturur.
func HashPassword(password string) (string, error) { //şifreyi alacak ve string döndürsün
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost) //generate işlemi ve defaultcost değeri :10 kullansın
	if err != nil {
		return "", fmt.Errorf("failed to hash password : %w", err) //hata varsa "" boş dönsün ve hata mesajını bas
	}
	return string(hashedPassword), nil //hata yoksada hash dizesini döndür
}

// şifrenin doğruluğunu kontrol et parolayı alıp ,hash değeri ile eşleştirecek
func CheckPassword(password string, hashedPassword string) error {
	return bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password)) //standart bcrypt paketi bu işi otomatik yapar,iki değeri karşılatırır
}
