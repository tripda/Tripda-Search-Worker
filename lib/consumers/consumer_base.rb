require 'sneakers'

class ConsumerBase
  include Sneakers::Worker

  def initialize(http_client)
    @http_client = http_client
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
