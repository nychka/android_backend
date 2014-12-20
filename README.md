API documentation
=================

export ROOT_URL=http://localhost:3000
export EMAIL=test@example.com

register 
===
request:
---
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST $ROOT_URL/users.json -d '{"user": {"email": "test@example.com", "password": "password"}}'
---
response:
---
{"id":2,"email":"test@example.com","authentication_token":"zzCNgoBpbXjWY87-sWyx"}
---

try to register user with the same credentials
response:
---
{"errors":{"email":["has already been taken"]}}
---


sign_in with valid email and password
===
request:
---
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST $ROOT_URL/users/sign_in -d '{"user": {"email": "test@example.com", "password": "password"}}'
---
response:
---
{"id":1,"email":"test@example.com","authentication_token":"zzCNgoBpbXjWY87-sWyx"}
export TOKEN=zzCNgoBpbXjWY87-sWyx
---
sign_in with invalid email or password
===
request:
---
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST $ROOT_URL/users/sign_in -d '{"user": {"email": "test@example.com", "password": "wrong_password"}}'
---
response:
---
{"error":"Invalid email or password."}
---

sign_out with valid token
===
request:
---
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X DELETE $ROOT_URL/users/sign_out -d '{"user": {"authentication_token": "zzCNgoBpbXjWY87-sWyx"}}'
---
response:
---
204 no content
---

get products list
===
unauthorized request:
---
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X GET $ROOT_URL/products
---
response:
---
{"error":"You need to sign in or sign up before continuing."}
---
authorized request:
---
curl -i -H 'Accept: application/json' -H 'Content-Type: application/json' -H "X-User-Email: $EMAIL" -H "X-User-Token: $TOKEN" -X GET $ROOT_URL/products
---