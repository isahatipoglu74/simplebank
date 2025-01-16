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
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up
# migrate aracını kullanarak yukarı migrasyonları (up migrations) uygular.

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down
# migrate aracını kullanarak aşağı migrasyonları (down migrations) uygular.

sqlc:	
	sqlc generate
# sqlc aracını kullanarak SQL sorgularından Go kodu oluşturur.

test:
	go test -v -cover ./...
#Go projenizdeki tüm test dosyalarını çalıştırarak test sonuçlarını ve kod kapsamını gösterir.

.PHONY:postgres createdb dropdb migrateup migratedown sqlc
# Makefile içindeki belirli hedeflerin sanal hedefler olduğunu belirtir. Bu, bu hedeflerin bir dosya ile çakışmasını önler ve her zaman çalıştırılmasını sağlar.