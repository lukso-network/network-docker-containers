# JWT secret

Execute the following command from the root directory of this repository:

```sh
openssl rand -hex 32 | tee ./jwtsecret/jwt.hex > /dev/null
```