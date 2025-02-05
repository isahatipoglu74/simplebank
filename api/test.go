package api

import (
	"crypto/hmac"
	"crypto/md5"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"time"
)

// HMACSHA256 imzası oluşturma
func getSignature(secretKey, message string) string {
	byteKey := []byte(secretKey)
	h := hmac.New(sha256.New, byteKey)
	h.Write([]byte(message))
	return hex.EncodeToString(h.Sum(nil))
}

// md5 hash hesaplama
func md5Hash(text string) string {
	hash := md5.Sum([]byte(text))
	return hex.EncodeToString(hash[:])
}

func main() {
	// Kullanıcı adı ve parola
	userName := "admin"
	password := "4dm1n2025#N3w"

	// Parolanın md5 hash değeri
	passwordHash := md5Hash(password)

	// UNIX zaman damgası (LoginTime)
	loginTime := time.Now().Unix()

	// SecretKey oluşturma
	secretKey := fmt.Sprintf("%s%d", passwordHash, loginTime)

	// Message oluşturma
	action := "LIST_BACKUPS"
	message := fmt.Sprintf(`{"Action": "%s","UserName": "%s","SignatureVersion": 2,"LoginTime": "%d"}`, action, userName, loginTime)

	// HMACSHA256 imzası oluşturma
	signature := getSignature(secretKey, message)

	fmt.Println("LoginTime:", loginTime)
	fmt.Println("Signature1:", signature)
}
