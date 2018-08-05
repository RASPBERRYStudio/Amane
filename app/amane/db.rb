require 'active_record'
require 'dotenv/load'

ActiveRecord::Base.establish_connection(
  adapter:  "postgresql",
  host:     ENV["DB_HOST"],
  username: ENV['DB_USER'],
  password: ENV['DB_PASS'],
  database: ENV['DB_NAME']
)