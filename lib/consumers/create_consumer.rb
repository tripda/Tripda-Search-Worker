require_relative 'consumer_base'
require 'multi_json'
require 'faraday'
require 'elasticsearch/api'

class CreateConsumer < ConsumerBase
  def process_message(body)
    method = @config['consumer.create.elasticsearch.method']
    path = @config['consumer.create.elasticsearch.path']

    run_request(method, path, body)
  end
end
