# Tecsolfacil

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Populate the seeds with user, running `mix run priv/repo/seeds.exs` 
  * Start Phoenix endpoint with `mix phx.server`

Start core application at [`localhost:4000`](http://localhost:4000).
Start swoosh mailer box preview at [`localhost:4001`](http://localhost:4001) from your browser.

All email notifications (endpoint: api/v1/address/report) use swoosh local adapter, as a poc.


# Doc API:
## Authentication (/api/v1/user/token)
METHOD: Post
Must pass a username and a password

```bash
curl -XPOST -H "Content-type: application/json" -d '{"user": {"username": "admin", "password": "5ECR7P455w0RD"}}' 'localhost:4000/api/v1/user/token'
```

## SearchCep (/api/v1/address/[cep]] {need authentication}
METHOD: Get
Must pass a JWT token

```bash
curl -XGET -H 'authorization: bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ0ZWNzb2xmYWNpbCIsImV4cCI6MTY0OTk3NTEzNiwiaWF0IjoxNjQ5OTcxNTM2LCJpc3MiOiJ0ZWNzb2xmYWNpbCIsImp0aSI6ImM4ODM4ZTY1LWUyYmYtNGRhOS1hOTRhLTY0NDgxZGE1Nzk5MCIsIm5iZiI6MTY0OTk3MTUzNSwic3ViIjoiMSIsInR5cCI6ImFjY2VzcyJ9.7N62BQmRQZyNbCZX2fiQJzILAkOIYDjUZgI_yAKLPMf_5sQ2EqvOdk86kG5ji6oJ-BnoH7wizVtJS6koVRnA4A' -H "Content-type: application/json" 'localhost:4000/api/v1/address/05014000'
```

## SearchCep (/api/v1/address/report] {need authentication}
METHOD: Get
Must pass a JWT token and a email in body

```bash
curl -XPOST -H 'authorization: bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ0ZWNzb2xmYWNpbCIsImV4cCI6MTY0OTk3NTEzNiwiaWF0IjoxNjQ5OTcxNTM2LCJpc3MiOiJ0ZWNzb2xmYWNpbCIsImp0aSI6ImM4ODM4ZTY1LWUyYmYtNGRhOS1hOTRhLTY0NDgxZGE1Nzk5MCIsIm5iZiI6MTY0OTk3MTUzNSwic3ViIjoiMSIsInR5cCI6ImFjY2VzcyJ9.7N62BQmRQZyNbCZX2fiQJzILAkOIYDjUZgI_yAKLPMf_5sQ2EqvOdk86kG5ji6oJ-BnoH7wizVtJS6koVRnA4A' -H "Content-type: application/json" -d '{"email": "admin@email.com"}' 'localhost:4000/api/v1/address/report'
```