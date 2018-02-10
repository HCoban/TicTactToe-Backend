# TicTacToe Backend

## Usage

- Clone the repository `git clone https://github.com/HCoban/TicTactToe-Backend.git`
- Go to directory `cd TicTacToe-Backend`
- Change the environmental variable `HMAC_SECRET` in `Dockerfile` if you would like to
- Run `docker-compose up`
- After the build, in a new terminal window
  - Create the database `docker-compose exec website rails db:create`
  - Run migrations `docker-compose exec website rails db:migrate`
- Open `index.html` in the [frontend](https://github.com/HCoban/TicTactToe-Frontend) and play the game.
- Run tests by `docker-compose exec website bundle exec rspec`

## Technologies

- Ruby on Rails
- Jason Web Token
- PostgreSQL
- jbuilder
- rspec
- docker

## Features

- A RESTFUL Api rendering JSON response
- Token based authentication without the need to store any passwords or tokens
- Test driven development

## Details

The postgreSQL database has three tables, `games`, `marks`, and `players`. `Game`s has many `player`s and `mark`s. `Player`s belong to a `game` and has many `marks`. `Mark`s belong to a `game` and a `player`. Model files can be found at `app/models/`.

`router.rb` defines RESTful routes under an `API` namespace. The routes can be viewed by running `docker compose exec website rails routes`. There are currently two controllers `GamesController` and `MarksController`. GamesController has `create` and `show` actions whereas `MarksController` has only `create` action.

`GamesController#create` is responsible for creating a new game as well as a Jason Web Token and rendering `app/views/api/games/show.json.jbuilder`. Jbuilder gem declares JSON structures. `#show` method is rendering also the same `app/views/api/games/show.json.jbuilder` and does not make any token check.

`MarksController#create` is responsible for making token checks and creating a new mark (a new move in game) or rendering errors. If the result is successful `app/views/api/marks/show.json.jbuilder` is rendered.

All test files are under `spec/` folder and can be run by `docker-compose exec website bundle exec rspec`.