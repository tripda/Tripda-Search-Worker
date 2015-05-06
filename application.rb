$: << File.expand_path('./lib', File.dirname(__FILE__))
require 'sneakers'
require 'sneakers/runner'
require 'consumers/create_consumer'
require 'consumers/update_consumer'
require 'consumers/delete_consumer'
require 'requester/http_client'
require 'yaml'
require 'faraday'

config = YAML.load_file("config/config.dist.yml")
opts = {
    :amqp => config['sneakers.config.amqp'],
    :vhost => config['sneakers.config.vhost'],
    :exchange_type => config['sneakers.config.exchange_type'],
    :workers => Integer(config['sneakers.config.workers'])
}

Sneakers.configure(opts)
Sneakers.logger.level = Logger::INFO

WORKER_OPTIONS = {
    :durable => true,
    :ack => true,
    :threads => 1,
    :prefetch => 0,
    :timeout_job_after => 1,
    :heartbeat => 1
}

request = HttpClient.new(::Faraday::Connection.new url:config['elastisearch.host'])
request.method = config['consumer.create.elasticsearch.method']
request.path = config['consumer.create.elasticsearch.path']

CreateConsumer.requester = request
CreateConsumer.from_queue config['consumer.create.queue'],
                          WORKER_OPTIONS.merge(:exchange => config['consumer.create.exchange'])

#
# UpdateConsumer.requester request
# UpdateConsumer.from_queue config['consumer.create.update'],
#                           WORKER_OPTIONS.merge(:exchange => config['consumer.update.exchange'])
#
# DeleteConsumer.requester request
# DeleteConsumer.from_queue config['consumer.delete.queue'],
#                           WORKER_OPTIONS.merge(:exchange => config['consumer.delete.exchange'])


r = Sneakers::Runner.new([CreateConsumer])
r.run