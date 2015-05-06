require_relative 'consumer_base'

class DeleteConsumer < ConsumerBase

  def process_message(body)
    @requester.request(body)
  end
end