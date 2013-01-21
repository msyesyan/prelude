require "pry"
require "capsum/typical"

set :application, "prelude"
set :shared, %w{
  config/mongoid.yml
}