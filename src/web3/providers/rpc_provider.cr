require "http/client"

require "./base_provider"
require "../exceptions/error_response_exception"
require "../models/base_request"
require "../models/base_response"
require "../models/error_response"

module Web3
  include Exceptions
  include Models

  module Providers
    class RpcProvider < BaseProvider

      getter url : String

      class_property id = 1

      def initialize(@url : String)
      end

      def request(request : BaseRequest, result_type : ResultT.class) forall ResultT
        request.id = @@id

        response = HTTP::Client.post(@url, body: request.to_json, headers: headers)
        @@id += 1
        json = response.body.is_a?(String) ? response.body.as(String) : response.body_io.gets

        if json.is_a? String
          begin
            ResultT.from_json(json).result
          rescue
            raise ErrorResponseException.new ErrorResponse.from_json(json)
          end
        else
          raise ErrorResponseException.new(ErrorResponse.new("No response!"))
        end
      end

      private def headers
        HTTP::Headers{"Content-Type" => "application/json"}
      end
    end
  end
end
