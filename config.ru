require './config/environment'
require 'bundler'
if ActiveRecord::Migrator.needs_migration?

  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end



use Rack::MethodOverride
use DishesController
use ChefsController
run ApplicationController
