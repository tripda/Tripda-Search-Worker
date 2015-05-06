$: << File.expand_path('./consumers', File.dirname(__FILE__))
require 'sneakers'
require 'sneakers/runner'
require 'create_consumer'
require 'update_consumer'
require 'delete_consumer'

opts = {
    :amqp => 'amqp://test:test@localhost:5672',
    :vhost => '/trip',
    :exchange_type => :direct,
    :workers => 1
}
Sneakers.configure(opts)
Sneakers.logger.level = Logger::INFO
r = Sneakers::Runner.new([CreateConsumer, UpdateConsumer, DeleteConsumer])
r.run