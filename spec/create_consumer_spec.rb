require_relative '../lib/consumers/create_consumer'
require 'yaml'
require 'http_client_mock'

describe CreateConsumer do
  before :each do
    @createConsumer = CreateConsumer.new
  end

  describe "#process_message" do

    context "positive result" do
      it "make request and get result from elasticsearch" do
        result = "{\"_index\": \"teste\", \"_type\": \"type\", \"_id\": \"1\", \"_version\": 1, \"created\": true}"
        request = HttpClientMock.new
        CreateConsumer.requester = request
        expect(@createConsumer.process_message("{\"status\":true}")).to eq(result)
      end
    end

    context "negative result" do
      it "make request and get result from elasticsearch" do
        result = "{\"error\": \"IndexAlreadyExistsException[[teste] already exists]\", \"status\": 400}"
        request = HttpClientMock.new
        CreateConsumer.requester = request
        expect(@createConsumer.process_message("{\"status\":false}")).to eq(result)
      end
    end

  end
end