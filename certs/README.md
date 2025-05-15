Place your SSL certificates here:

- ca.crt
- server.crt
- server.key

To generate self-signed certs for testing:

```sh
openssl req -x509 -newkey rsa:4096 -keyout server.key -out server.crt -days 365 -nodes -subj "/CN=localhost"
cp server.crt ca.crt
```
