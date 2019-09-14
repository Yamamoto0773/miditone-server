# miditone-server
Ranking server for miditone#, Koreisai2019 5J Project.

## Using
- Docker
- in Docker container
  - Ruby 2.6.4
  - Rails 6.0.0
  - MySQL 8.0

## How to Build
How to build in case of using docker. If you don't use docker, see [this desciption](#execute-without-Docker).

type commands in your terminal
```sh
$ git clone https://github.com/Yamamoto0773/miditone-server.git
$ cd miditone-server
$ source env.sh
$ build
$ rake db:create ridgepole:apply
```

## Launch
move to app directory, and then type
```sh
$ up
```
Lanch complete when displayed 'Use Ctrl-C to stop' in your terminal

## Terminate
type `ctrl-c` in your terminal where running application

or, in another terminal

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
please replace `username` and `password` with you like
```sh
$ mysql -u root -p # enter mysql terminal, require root password
> CREATE USER 'username'@'localhost' IDENTIFIED BY 'password'; # create user by username and password
> GRANT ALL ON *.* TO 'username'@'localhost'; # grant permission to created user
> exit
```
5. Move to Application directory, and update `config/database.yml`.  
change username, password and host in default section.
```yml
(truncated)

default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: username # update to username you set at step.4
  password: password # update to password you set at step.4
  host: localhost # update to localhost
 
(truncated)
```
6. Install gems  
first, move to application directory.
```sh
$ bundle exec bundle install --path ./vendor/bundle
```
7. Create database for application
```sh
$ bundle exec rake db:create ridgepole:apply
```
8. Launch Web Server
```sh
bundle exec rails s -b 0.0.0.0
```
9. Terminate Web Server  
please type `ctrl-c` in your terminal where running application.
