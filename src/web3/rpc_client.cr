require "http/client"

require "./models/base_request"
require "./models/base_response"

module Web3
  include Models

  class RpcClient
    JSONRPC_VERSION = "2.0"

    getter url : String

    @@id = 1

    def initialize(@url : String)
    end

    def request(request : BaseRequest, result_type : ResultT.class) forall ResultT
      request.id = @@id

      HTTP::Client.post(@url, body: request.to_json, headers: headers) do |response|
        @@id += 1
        json = response.body_io.gets
        if json.is_a? String
          begin
            result = ResultT.from_json json
            result.headers = response.headers
            result.protocol_version = response.version
            result.status_code = response.status_code
            return result
          rescue
            result = BaseResponse.from_json json
            result.headers = response.headers
            result.protocol_version = response.version
            result.status_code = response.status_code
            return result
          end
        end
        nil
      end
    end

    private def headers
      HTTP::Headers{"Content-Type" => "application/json"}
    end

    def self.id
      @@id
    end
  end
end
