require "http/web_socket"

require "./base_provider"
require "../exceptions/error_response_exception"
require "../models/base_request"
require "../models/base_response"
require "../models/error_response"

module Web3
  include Exceptions
  include Models

  module Providers
    class WsProvider < BaseProvider

      getter uri : URI

      class_property id = 1

      def initialize(url : String)
        @uri = URI.parse url
      end

      def request(request : BaseRequest, result_type : ResultT.class) forall ResultT
        request.id = @@id

        socket = HTTP::WebSocket.new(@uri)

        result = nil

        socket.on_message do |json|
          socket.close
          if json.is_a? String
            begin
              result = ResultT.from_json(json).result
            rescue
              raise ErrorResponseException.new ErrorResponse.from_json(json)
            end
          else
            raise ErrorResponseException.new(ErrorResponse.new("No response!"))
          end
        end

        socket.send request.to_json
        @@id += 1
        socket.run

        result.not_nil!
      end
    end
  end
end
