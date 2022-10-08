FROM bitwalker/alpine-elixir:1.13.4 as build

RUN apk update && apk upgrade --no-cache && \
  apk add ncurses-libs libgcc libstdc++ build-base openssh-client postgresql-client

WORKDIR /app

RUN mix do local.hex --force, local.rebar --force

COPY . ./  

RUN mix do deps.get, deps.compile