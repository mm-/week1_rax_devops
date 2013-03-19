require 'fog'

# Set our custom fog credentials file:
ENV['FOG_RC'] = '~/.rackspace_cloud_credentials'

# CDB Flavor ID
flavor_id = '1'

instance_name = 'testinst1'
instance_volume_size = '1'

database_name = 'testdb1'


# Create a connection
connection = Fog::Rackspace::Databases.new({
#	:provider		=> 'Rackspace',
#	:version		=> :v2,
#	:rackspace_region	=> :dfw,
})


instance = connection.instances.create(:name => instance_name, :flavor_id => flavor_id, :volume_size => instance_volume_size)


instance.wait_for { ready? }

#instances = connection.instances 
#databases = instance.databases


#database = instance.databases

#puts instances.to_s

#flavors = connection.flavors

#puts flavors.to_s


# This creates a database, but it still throws an error:
# challenge5.rb:45:in `<main>': undefined local variable or method `databases' for main:Object (NameError)
database = instance.databases.create( :name => database_name)

#puts databases.to_s

database.wait_for { ready? }



