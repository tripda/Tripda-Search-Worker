require 'sneakers'

class ConsumerBase
  include Sneakers::Worker

  attr_accessor :http_client

  def initialize()
    super()
    @config = YAML.load_file(File.dirname(__FILE__)+"/../../config/config.yml")
    @http_client = ::Faraday::Connection.new url: @config['elastisearch.host']
  end

  def run_request(method, path, body)
    @http_client.run_request \
      method.downcase.to_sym,
      path,
      ( body ? MultiJson.dump(body): nil ),
      {'Content-Type' => 'application/json'}
  end

  def work(msg)
    process_message(msg)
    logger.info "#{msg}"
    ack!
  end

  def process_message(msg)
    raise 'Called abstract method: process'
  end
end
