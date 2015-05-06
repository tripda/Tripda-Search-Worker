require_relative 'consumer_base'

class UpdateConsumer < ConsumerBase

  def process_message(body)
    @requester.request(body)
  end
end