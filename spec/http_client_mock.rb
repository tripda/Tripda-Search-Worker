
class HttpClientMock
  def run_request(method, path, body, meta)
    if body
      "{\"_index\": \"teste\", \"_type\": \"type\", \"_id\": \"1\", \"_version\": 1, \"created\": true}"
    else
      "{\"error\": \"IndexAlreadyExistsException[[teste] already exists]\", \"status\": 400}"
    end
  end
end