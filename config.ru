require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

ActiveRecord::Base.logger = Logger.new(STDOUT)

use Rack::MethodOverride
use TripsController
use UsersController
use SouvenirsController
run ApplicationController