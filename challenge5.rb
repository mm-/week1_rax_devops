require 'fog'

# Set our custom fog credentials file:
ENV['FOG_RC'] = '~/.rackspace_cloud_credentials'

# CDB Flavor ID
flavor_id = '1'

instance_name = 'testinst1'
instance_volume_size = '1'

database_name = 'testdb1'


user_name = 'testuser'
password = 'testpass'

# Create a connection
connection = Fog::Rackspace::Databases.new({
#	:provider		=> 'Rackspace',
#	:version		=> :v2,
#	:rackspace_region	=> :dfw,
})


instance = connection.instances.create(:name => instance_name, :flavor_id => flavor_id, :volume_size => instance_volume_size)


instance.wait_for { ready? }


# This creates a database, but it still throws an error:
# challenge5.rb:45:in `<main>': undefined local variable or method `databases' for main:Object (NameError)

database = instance.databases.create( :name => database_name)

database_state = instance.database.first.state.to_s

#database.wait_for { ready? }

#database_state = database.state.to_s

until database_state == 'ACTIVE'
  database_state = instance.database.first.state.to_s
end

#TODO - user creation is still failing, unsure about the cause
user = instance.users.create( :name => user_name, :password => password, :databases => database_name)
