echo ' {
    "username": "it16",
    "password": "it16password"
}' > register.json

ab -n 100 -c 10 -p register.json -T application/json http://atreides.it16.com:8001/api/auth/register