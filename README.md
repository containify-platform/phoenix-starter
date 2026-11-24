# Phoenix starter

[![Deploy on Containify](https://containify.cloud/deploy-button.svg)](https://containify.cloud/templates/phoenix)

A minimal [Phoenix](https://www.phoenixframework.org) 1.8 LiveView app on Elixir 1.20 with a
PostgreSQL database, ready to deploy on [Containify](https://containify.cloud). The home page is
a LiveView that records each visit in Postgres and shows the count, updating live in every open
tab; `/healthz` is the health check.

The production image is a `mix release` on Debian, running as `nobody`: it has the Erlang
runtime but neither Elixir nor the source code. It listens on port 4000, on IPv6 and IPv4.

## Deploy on Containify

[![Deploy on Containify](https://containify.cloud/deploy-button.svg)](https://containify.cloud/templates/phoenix)

One click deploys it on [Containify](https://containify.cloud). The [template page](https://containify.cloud/templates/phoenix) shows what it creates, and passwords, connection strings and the HTTPS address are filled in for you.

Deploy the **Phoenix starter** template from the Containify catalogue. It creates:

- **Phoenix**, built from this repository, with an HTTPS endpoint on port 4000 and a health check on `/healthz`.
- **Postgres**, a private PostgreSQL 17 database with a volume.

`SECRET_KEY_BASE` is generated for you, `DATABASE_URL` references the Postgres app, `PHX_HOST`
follows the app's public hostname, and `/app/bin/migrate` runs as the pre-deploy command, so
migrations run once per deploy before the new version takes traffic.

To build your own app from it, fork this repository and point the app's source at your fork.
See the [Phoenix guide](https://containify.cloud/docs/guides/phoenix).

## Run locally

You need Elixir 1.15 or newer and PostgreSQL. The development database is
`phoenix_starter_dev` on `localhost`, as user `postgres` with password `postgres`
(see `config/dev.exs`).

```bash
mix setup
mix phx.server
```

Then open [localhost:4000](http://localhost:4000).

Or run the production image with Docker:

```bash
docker build -t phoenix-starter .
docker run -p 4000:4000 \
  -e SECRET_KEY_BASE=$(openssl rand -base64 48) \
  -e DATABASE_URL=postgresql://postgres:postgres@host.docker.internal:5432/app \
  -e PHX_HOST=localhost \
  phoenix-starter sh -c '/app/bin/migrate && exec /app/bin/server'
```

## Environment

| Variable          | What it does                                                                    |
| ----------------- | ------------------------------------------------------------------------------- |
| `DATABASE_URL`    | Postgres connection string. Required.                                           |
| `SECRET_KEY_BASE` | Signs and encrypts cookies; at least 64 characters. Required.                   |
| `PHX_HOST`        | The public hostname; falls back to `CONTAINIFY_PUBLIC_DOMAIN`. LiveView only accepts connections from it. |
| `ECTO_IPV6`       | `true` to connect to Postgres over IPv6, as on Containify's private network.    |
| `POOL_SIZE`       | Database connections; 10 unless set.                                            |
| `PORT`            | The HTTP port; 4000 unless set.                                                 |

## License

MIT

---

Made by [Containify](https://containify.cloud): deploy apps, databases and workers from a Git repo or an image, with per-second billing. [Docs](https://containify.cloud/docs) · [Templates](https://containify.cloud/templates)
