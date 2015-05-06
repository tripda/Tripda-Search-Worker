require 'sneakers'

class ConsumerBase
  include Sneakers::Worker

  @@requester = nil

  def ConsumerBase.requester= (request)
    @@requester = request
  end

  def ConsumerBase.requester
    return @@requester
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