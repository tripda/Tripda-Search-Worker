require_relative 'consumer_base'

class CreateConsumer < ConsumerBase

  def process_message(body)
      @@requester.request(body)
  end
end