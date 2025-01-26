package token

import (
	"errors"
	"time"

	"github.com/google/uuid"
)

var (
	ErrInvalidToken = errors.New("token has invalid")
	ErrExpiredToken = errors.New("token has expired")
)

/*
Bu veri seti, kullanıcının kimliği, roller, yetkiler ve token'ın geçerlilik süresi gibi bilgileri barındırır.
Payload, Base64URL ile kodlanır ve bir JSON nesnesi olarak saklanır.
*/
type Payload struct { //Tokenın ve sahibinin bilgileri
	ID        uuid.UUID `json:"id"`         //uniqliğini ifade etmes için
	Username  string    `json:"username"`   //kullanıcı adı
	IssuedAt  time.Time `json:"issued_at"`  //tokenın ne zaman oluşturlduğu
	ExpiredAt time.Time `json:"expired_at"` //tokenın bitiş tarihi
}

// yeni bir token yükü
func NewPayload(username string, duration time.Duration) (*Payload, error) { //Belirtilen kullanıcı adı ve süre ile yeni bir token yükü oluşturur.
	tokenID, err := uuid.NewRandom() //yeni benzersiz bir token oluşturur
	if err != nil {
		return nil, err
	}

	payload := &Payload{
		ID:        tokenID,
		Username:  username,
		IssuedAt:  time.Now(),
		ExpiredAt: time.Now().Add(duration),
	}

	return payload, nil

}

func (payload *Payload) Valid() error { //token geçerlilini kontrol eder
	if time.Now().After(payload.ExpiredAt) {
		return ErrExpiredToken
	}
	return nil
}
