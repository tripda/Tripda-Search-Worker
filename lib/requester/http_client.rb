class HttpClient
  attr_accessor :path, :method

  def initialize(connection)
    @connection = connection
  end

  def request(body)
    @connection.run_request \
      @method.downcase.to_sym,
      @path,
      ( body ? MultiJson.dump(body): nil ),
      {'Content-Type' => 'application/json'}
  end
end