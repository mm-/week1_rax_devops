require 'fog'


ENV['FOG_RC'] = '~/.rackspace_cloud_credentials'


dns = Fog::DNS.new({
    :provider => 'Rackspace',
    #:rackspace_email => 'mithofrose@gmail.com',
                 })



zone = dns.zones.create(
    :domain => 'topseller.org',
    :email => 'lol@topseller.org'
)


record = zone.records.create(
    :value => '8.8.8.8',
    :name => 'topseller.org',
    :type => 'A'
)


