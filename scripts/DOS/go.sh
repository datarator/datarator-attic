#/bin/sh

# inspiration: https://easyengine.io/tutorials/nginx/block-wp-login-php-bruteforce-attack/

# make sure server accepts only 1 req per sec
ab -n 10000 -c 10 -T POST -p test.json 127.0.0.1:9292/api/schemas
