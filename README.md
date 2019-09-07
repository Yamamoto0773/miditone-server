# miditone-server
Ranking server for miditone#, Koreisai2019 5J Project.

### Using
- Docker
- in Docker container
  - Ruby 2.6.4
  - Rails 6.0.0
  - MySQL 8.0

### How to Build
how to build in case of using docker.  

type commands in your terminal
```sh
git clone https://github.com/Yamamoto0773/miditone-server.git
cd miditone-server
source env.sh
build
rails db:create
```

### Launch
move to app directory, and then type
```sh
up
```
Lanch complete when displayed 'Use Ctrl-C to stop' in your terminal

### Terminate
type `ctrl-c` in your terminal where running application
