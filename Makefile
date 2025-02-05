DB_URL=postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable
postgres:
	docker run --name postgres17 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:17-alpine
# Docker konteyneri içinde PostgreSQL veritabanı sunucusunu başlatır.

createdb:
	docker exec -it postgres17 createdb --username=root --owner=root simple_bank
# postgres17 adlı Docker konteyneri içinde simple_bank adlı bir PostgreSQL veritabanı oluşturur.

dropdb:
	docker exec -it postgres17 dropdb simple_bank
# postgres17 adlı Docker konteyneri içinde simple_bank veritabanını siler.

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up
# migrate aracını kullanarak yukarı migrasyonları (up migrations) uygular.

migrateup1:
	migrate -path db/migration -database "$(DB_URL)"  -verbose up
# migrate aracını kullanarak mevcuttakinden 1 üstteki versiyona geçiş yapar

migratedown:
	migrate -path db/migration -database "$(DB_URL)"  -verbose down
# migrate aracını kullanarak aşağı migrasyonları (down migrations) uygular.

migratedown1:
	migrate -path db/migration -database "$(DB_URL)"  -verbose down 1
# migrate aracını kullanarak mevcuttakinden 1 alltaki versiyona geçiş yapar

db_docs:
	dbdocs build doc/db.dbml

db_schema:
	dbml2sql --postgres -o doc/schema.sql doc/db.dbml

sqlc:	
	sqlc generate
# sqlc aracını kullanarak SQL sorgularından Go kodu oluşturur.

test:
	go test -v -cover ./...
#Go projenizdeki tüm test dosyalarını çalıştırarak test sonuçlarını ve kod kapsamını gösterir.

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go simplebank/db/sqlc Store

.PHONY:postgres createdb dropdb migrateup migratedown  migrateup1 migratedown1 db_docs db_schema sqlc test server mock
# Makefile içindeki belirli hedeflerin sanal hedefler olduğunu belirtir. Bu, bu hedeflerin bir dosya ile çakışmasını önler ve her zaman çalıştırılmasını sağlar.