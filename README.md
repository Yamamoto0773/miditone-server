# miditone-server
Ranking server for miditone#, Koreisai2019 5J Project.

## Index

- [Using](#using)
- [How to Build](#how-to-build)
- [Create Token](#create-token)
- [Launch](#launch)
- [Terminate](#terminate)
- [Execute without Docker](#execute-without-docker)
- [API Routes](#api-routes)
- [Authorization](#authorization)
- [Request Parameters](#request-parameters)


## Using
- Docker
- in Docker container
  - Ruby 2.6.4
  - Rails 6.0.0
  - MySQL 8.0
- Authenticated by
  - `ActionController::HttpAuthentication::Token`
  - hashed by `SHA::512` in creating token

## How to Build
⚠️ **Please Use Bash Terminal**
How to build in case of using docker. If you don't use docker, see [this desciption](#execute-without-Docker).

please type command on your terminal
```sh
$ git clone https://github.com/Yamamoto0773/miditone-server.git
$ cd miditone-server
$ source env.sh
$ build
$ rake db:create ridgepole:apply db:seed
```

## Create Token
In application root directory, type following command to create token with `name` and `key`.
please replace`name` and `key` with something. **DO NOT INSERT SPACE AFTER COMMA.**
```sh
$ rake token:create[name,key]
```
example
```sh
$ rake token:create[sample,secure]
```
after running, token will be displayed on your terminal.

see also : [Authorization](#authorization)

## Launch
Type commands in application root directory
```sh
$ up
```
Launch complete when 'Use Ctrl-C to stop' is printed on your terminal.

## Terminate
Please type `ctrl-c` on your terminal where application is running.

Or, on another terminal

1. find working containers
```sh
$ docker container ls
```
2. stop and remove containers
```sh
$ docker container stop <CONTAINER ID>
```

## Execute without Docker
1. Install Ruby2.6.4, Rails 6.0.0 and MySQL 8.0.
2. Add following lines to '/etc/mysql/my.cnf' to set database encoding.
```
[client]
default-character-set=utf8mb4

[mysqld]
character-set-server=utf8mb4
```
3. Restart database to apply encoding settings
```sh
$ server mysql restart
```
4. Create a user of mysql.
please replace `username` and `password` with something
```sh
$ mysql -u root -p # enter mysql terminal, require root password
> CREATE USER 'username'@'localhost' IDENTIFIED BY 'password'; # create user with username and password
> GRANT ALL ON *.* TO 'username'@'localhost'; # grant permission to created user
> exit
```
5. Move to Application root directory, and edit `config/database.yml`.
change username, password and host in default section.
```yml
(truncated)

default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: username # change to username you set at step.4
  password: password # change to password you set at step.4
  host: localhost # change to localhost

(truncated)
```
6. Install gems
in application root directory
```sh
$ bundle exec bundle install --path ./vendor/bundle
```
7. Create database for application
```sh
$ bundle exec rake db:create ridgepole:apply
```
8. Create Token
please replace `name` and `key` with something. **DO NOT INSERT SPACE AFTER COMMA.**
after running, token will be displayed on your terminal.
```sh
$ bundle exec rake token:create[name,key]
```
9. Launch Web Server
```sh
bundle exec rails s -b 0.0.0.0
```
10. Terminate Web Server
please type `ctrl-c` on your terminal where application is running.


## API Routes
⚠️ **Need Authorization Token at All End Points**

scope `platform` indicates game version.
please specify `button` or `board`.


|URI|VERB|DESCRIPTION|PARAMETERS|
|--|--|--|--|
|`/api/users`                                 |`GET`    |get users||
|`/api/users         `                        |`POST`   |create a user|[params](#postput-user)|
|`/api/users/{qrcode}`                        |`GET`    |get a user specified by QR code|
|`/api/users/{qrcode}`                        |`PUT`    |update a user specified by QR code|[params](#postput-user)
|`/api/users/{qrcode}`                        |`DELETE` |destroy a user specified by QR code|
|`/api/users/{qrcode}/{platform}/preference`  |`GET`    |get user's preference|
|`/api/users/{qrcode}/{platform}/preference`  |`PUT`    |update user's preference|[params](#put-preference)
|`/api/users/{qrcode}/{platform}/scores`      |`GET`    |get user's scores|[params](#get-score)
|`/api/users/{qrcode}/{platform}/scores`      |`POST`   |create user's score|[params](#postput-score)
|`/api/users/{qrcode}/{platform}/scores/{id}` |`GET`    |get a score specified by record id|
|`/api/users/{qrcode}/{platform}/scores/{id}` |`PUT`    |update a score specified by record id|[params](#postput-score)
|`/api/users/{qrcode}/{platform}/scores/{id}` |`DELETE` |destroy a score specified by record id|
|`/api/musics`                                |`GET`    |get musics|
|`/api/musics`                                |`POST`   |create a music|[params](#postput-music)
|`/api/musics/{id}`                           |`GET`    |get a music specified by music ID|
|`/api/musics/{id}`                           |`PUT`    |update a music specified by music ID|[params](#postput-music)
|`/api/musics/{id}`                           |`DELETE` |destroy a music specified by music ID|
|`/api/musics/{id}/{platform}/ranking`        |`GET`    |get all user's scores of specified music|[params](#get-ranking)
|`/api/musics/{platform}/played_times`        |`GET`    |get played times of each musics|
|`/api/musics/{id}/{platform}/played_times`   |`GET`    |get played times of specified music|
|`/api/health_check`                          |`GET`    |for checking server


## Authorization
See also: [Create Token](#create-token).

Header Format
```http
Authorization: Bearer Token
```
please replace `Token` with created one.


## Request Parameters
### POST/PUT User
#### Parameters
```json
{
  "user": {
    "name": "user_name"
  }
}
```
#### Restriction
- `name` : String
  - length is 1 ~ 10 characters
  - only typeable characters by keyboard, except space and `\n`
     - all alphabets
     - all numbers
     - ~`!@#$%^&*()-_=+[]{};:'",.<>/?

#### Response
example
```json
{
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "qrcode": "480396536019",
      "name": "xak50c1bhp"
    },
    "relationships": {
      "preferences": {
        "data": [
          {
            "id": "1",
            "type": "preference"
          },
          {
            "id": "2",
            "type": "preference"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2",
      "type": "preference",
      "attributes": {
        "note_speed": 3.0,
        "se_volume": 3,
        "platform": "board"
      }
    },
    {
      "id": "1",
      "type": "preference",
      "attributes": {
        "note_speed": 3.0,
        "se_volume": 2,
        "platform": "button"
      }
    }
  ]
}
```

### PUT Preference
#### Parameters
```json
{
  "preference": {
    "note_speed": 6.5,
    "se_volume": 5
  }
}
```
#### Restriction
- `note_speed` : Number/Null
  - greater than or equal to 0.0 if not null
- `se_volume` : Number/Null
  - greater than or equal to 0 if not null

#### Response
example
```json
{
  "data": {
    "id": "1",
    "type": "preference",
    "attributes": {
      "note_speed": 3.0,
      "se_volume": 2,
      "platform": "button"
    }
  }
}
```

### GET Score
#### URL Parameters
```json
{
  "difficulty": "easy"
}
```
- **Need parameters if only you get scores of one difficulty.**

#### Restriction
- `difficulty` : String
  - only following strings
    - `"easy"`
    - `"normal"`
    - `"hard"`



#### Response
example
```json
{
  "data": [
    {
      "id": "1",
      "type": "score",
      "attributes": {
        "user_id": 1,
        "music_id": 1,
        "difficulty": "easy",
        "points": 600000,
        "max_combo": 200,
        "critical_count": 350,
        "correct_count": 120,
        "nice_count": 10,
        "miss_count": 20,
        "played_times": 1,
        "platform": "button"
      },
      "relationships": {
        "user": {
          "data": {
            "id": "1",
            "type": "user"
          }
        },
        "music": {
          "data": {
            "id": "1",
            "type": "music"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1",
      "type": "music",
      "attributes": {
        "title": "title",
        "artist": "artist"
      }
    }
  ]
}
```

### POST/PUT Score
#### Parameters
```json
{
  "score": {
    "music_id": "1",
    "difficulty": "normal",
    "points": "900000",
    "max_combo": "300",
    "critical_count": "400",
    "correct_count": "50",
    "nice_count": "10",
    "miss_count": "3"
  }
}
```

#### Restriction
- `music_id` : Number
  - existing music id
- `difficulty` : String
  - only following strings
    - `"easy"`
    - `"normal"`
    - `"hard"`
- `points` : Number
  - min: 0
  - max: 1,000,000
- `max_combo` : Number
  - min: 0
- `critical_count` : Number
  - min: 0
- `correct_count` : Number
  - min: 0
- `nice_combo` : Number
  - min: 0
- `miss_combo` : Number
  - min: 0


#### Response
same as GET Score


### POST/PUT Music
#### Parameters
```json
{
  "music": {
    "title": "title",
    "artist": "artist"
  }
}
```

#### Restriction
- `music` : String
  - not null
- `artist` : String
  - not null

#### Response
```json
{
  "data": {
    "id": "4",
    "type": "music",
    "attributes": {
      "title": "title",
      "artist": "artist"
    }
  }
}
```

### GET Ranking
#### URL Parameters
```json
{
  "difficulty": "normal"
}
```
- **Need parameters if only you get scores of one difficulty.**

#### Restriction
- `difficulty` : String
  - only following strings
    - `"easy"`
    - `"normal"`
    - `"hard"`

#### Response
- Elements are sorted in descending order of points
```json
{
  "data": [
    {
      "id": "2",
      "type": "score",
      "attributes": {
        "user_id": 1,
        "music_id": 1,
        "difficulty": "normal",
        "points": 900000,
        "max_combo": 300,
        "critical_count": 400,
        "correct_count": 50,
        "nice_count": 10,
        "miss_count": 3,
        "played_times": 1,
        "platform": "button"
      },
      "relationships": {
        "user": {
          "data": {
            "id": "1",
            "type": "user"
          }
        },
        "music": {
          "data": {
            "id": "1",
            "type": "music"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "1",
      "type": "music",
      "attributes": {
        "title": "title",
        "artist": "artist"
      }
    },
    {
      "id": "1",
      "type": "user",
      "attributes": {
        "qrcode": "480396536019",
        "name": "xak50c1bhp"
      },
      "relationships": {
        "preferences": {
          "data": [
            {
              "id": "1",
              "type": "preference"
            },
            {
              "id": "2",
              "type": "preference"
            }
          ]
        }
      }
    }
  ]
}
```
