require 'logger'
require 'sneakers'

class UpdateConsumer
  include Sneakers::Worker
  include Elasticsearch::API

  CONNECTION = ::Faraday::Connection.new url: 'http://localhost:9200'

  from_queue 'tripda.trip.update',
             :durable => true,
             :ack => true,
             :threads => 1,
             :prefetch => 0,
             :timeout_job_after => 1,
             :exchange => 'tripda.trip.direct',
             :heartbeat => 1

  def work(msg)
    self.doRequest('trip', msg)
    logger.info "#{msg}"
    ack!
  end

  def doRequest(path, body)

    CONNECTION.run_request \
      'put'.downcase.to_sym,
      path,
      ( body ? MultiJson.dump(body): nil ),
      {'Content-Type' => 'application/json'}
  end
end