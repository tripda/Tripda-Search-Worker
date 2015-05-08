require_relative '../lib/consumers/create_consumer'
require 'yaml'
require 'http_client_mock'

describe CreateConsumer do
  describe "#process_message" do

    before (:each) do
      http_client = HttpClientMock.new
      @consumer = CreateConsumer.new
      @consumer.http_client = http_client
    end

    context "when message could be processed" do
      it "should receive success json payload" do
        result = "{\"_index\": \"teste\", \"_type\": \"type\", \"_id\": \"1\", \"_version\": 1, \"created\": true}"
        expect(@consumer.process_message(true)).to eq(result)
      end
    end

    context "when message could not be processed" do
      it "should ?" do
        result = "{\"error\": \"IndexAlreadyExistsException[[teste] already exists]\", \"status\": 400}"
        expect(@consumer.process_message(false)).to eq(result)
      end
    end
  end
end
