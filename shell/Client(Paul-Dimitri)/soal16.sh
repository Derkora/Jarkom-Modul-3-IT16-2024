echo ' {
        "username": "it16",
        "password": "it16password"
}' > login.json

ab -n 100 -c 10 -p login.json -T application/json http://atreides.it16.com:8001/api/auth/login