require 'fog'

# Set our custom fog credentials file:
ENV['FOG_RC'] = '~/.rackspace_cloud_credentials'

directory_name = '/Users/mase4987/code/cf_test'

container_name = 'api_cf_test'

connection = Fog::Storage.new({
        :provider               => 'Rackspace',
        :version                => :v2,
#       :rackspace_region       => :dfw,
})

