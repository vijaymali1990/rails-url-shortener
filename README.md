# URL Shortener

URL Shortener application provide you short URL for any length of URL.
  - You can redirect to the original URL using short URL.
  - Gives you most accessed URL trends.

### Setup instructions

 - URL Shortener requires [Node.js](https://nodejs.org/) v6.10.2 to run
 - Npm version required is 4.5.0
 - Ruby version ruby 2.4.0 or higher
 - Rails version - 5.0.5 or higher
 - [Ruby on Rails Instructions](https://gorails.com/setup/osx/10.11-el-capitan)

Install the dependencies and devDependencies and start the server.

```sh
$ git clone https://github.com/vijaymali1990/rails-url-shortener
$ cd url-shorten
$ npm install
$ bundle install
$ cd client
$ yarn install
$ cd ..
```
 - Update the `config/database.yml` file for databse credentials for MySQL server.
 - Update `config/application.yml` file for URLs.

```sh
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ gem install foreman
$ foreman start -f Procfile.dev
```
This starts the server in development mode.
Building the assets for first time takes around 1-2 minutes for npm and rails.
Visit [Local Server](http://localhost:3000) should be able to see the main screen.
