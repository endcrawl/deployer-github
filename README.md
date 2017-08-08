## Github Integration for Deployer

Turn github webhooks into deployments. This is a [deployer](https://github.com/endcrawl/deployer) integration.

More documentation and packaging to come.

### Requirements

```sh
which python
python -c 'import http_parser'
python -c 'import simplejson'
which deploy
```

### Configuration

```sh
sudo cp ./etc/deployer-github.example.conf /etc/deployer-github.conf
sudo $EDITOR /etc/deployer-github.conf
```

### Usage: Standalone Server

```sh
sudo tcpserver -v 0.0.0.0 80 \
  setuidgid deployer \
    sh -c '. /etc/deployer-github.conf && exec "$0" "$@"' \
      deployer-github -- deploy
```

This assumes you also have `ucspi-tcp` and `daemontools` installed, and a privsep unix user named `deployer`.

### Usage: Behind Nginx

```sh
unixserver -v /var/lib/deployer-github/server.sock -- \
  setuidgid deployer \
    sh -c '. /etc/deployer-github.conf && exec "$0" "$@"' \
      deployer-github -- deploy
```

This assumes you also have `ucspi-unix` installed, and a privsep unix user named `deployer`.

Relevant nginx snippet:

```
location ~ ^/github/webhooks(/|$) {
  proxy_pass http://unix:/var/lib/deployer-github/server.sock;
}
```

