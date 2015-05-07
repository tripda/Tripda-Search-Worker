require_relative 'consumer_base'

class CreateConsumer < ConsumerBase
  def process_message(body)
      @http_client.request(body)
  end
end
