$: << File.expand_path('./lib', File.dirname(__FILE__))
require 'sneakers'
require 'sneakers/runner'
require 'consumers/create_consumer'
require 'yaml'

config = YAML.load_file("config/config.yml")
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

CreateConsumer.from_queue config['consumer.create.queue'],
                          WORKER_OPTIONS.merge(:exchange => config['consumer.create.exchange'])

worker_runner = Sneakers::Runner.new([CreateConsumer])
worker_runner.run
