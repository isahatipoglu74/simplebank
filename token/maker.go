package token

import "time"

// genel token oluşturacak bir interface oluşturduk
type Maker interface {
	CreateToken(username string, duration time.Duration) (string, error) //token oluşturacak (token ismi(jwt, paseto) ve süresi )

	VerifyToken(token string) (*Payload, error) //token geçerli olup olmamamsını kontrol eder
}
