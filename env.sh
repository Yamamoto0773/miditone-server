alias build="docker-compose build"
alias up="rm -f tmp/pids/server.pid && docker-compose up"
alias rails="docker-compose run --rm app bundle exec rails"
alias bundle="docker-compose run --rm app bundle"
