# mendapatkan token
curl -X POST -H "Content-Type: application/json" -d '{"username": "it16", "password": "it16password"}' http://atreides.it16.com:8001/api/auth/login | jq -r '.token' > token.txt
# set token
token=$(cat token.txt); curl -H "Authorization: Bearer $token" http://atreides.it16.com:8001/api/me
# jalankan /api/me
ab -n 100 -c 10 -H "Authorization: Bearer $token" http://atreides.it16.com:8001/api/me