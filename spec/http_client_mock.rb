require 'json'

class HttpClientMock
  def request(body)
      data = JSON.parse(body)
      if data['status']
        "{\"_index\": \"teste\", \"_type\": \"type\", \"_id\": \"1\", \"_version\": 1, \"created\": true}"
      else
        "{\"error\": \"IndexAlreadyExistsException[[teste] already exists]\", \"status\": 400}"
      end
  end
end