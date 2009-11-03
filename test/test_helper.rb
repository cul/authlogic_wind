require "test/unit"
require "rubygems"
require "ruby-debug"
require "active_record"
require 'shoulda'
require 'authlogic'
 
ActiveRecord::Schema.verbose = false
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
ActiveRecord::Base.configurations = true
ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.datetime :created_at
    t.datetime :updated_at
    t.integer :lock_version, :default => 0
    t.string :login
    t.string :crypted_password
    t.string :password_salt
    t.string :persistence_token
    t.string :single_access_token
    t.string :perishable_token
    t.string :wind_login
    t.string :email
    t.integer :login_count, :default => 0, :null => false
    t.integer :failed_login_count, :default => 0, :null => false
    t.datetime :last_request_at
    t.datetime :current_login_at
    t.datetime :last_login_at
    t.string :current_login_ip
    t.string :last_login_ip
  end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
# require 'authlogic_wind'


class Test::Unit::TestCase
end
