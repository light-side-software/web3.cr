require "socket"

require "./base_provider"
require "../exceptions/error_response_exception"
require "../models/base_request"
require "../models/base_response"
require "../models/error_response"

module Web3
  include Exceptions
  include Models

  module Providers
    class IpcProvider < BaseProvider

      getter path : String
      getter socket : UNIXSocket

      class_property id = 1

      def initialize(@path : String)
        @socket = UNIXSocket.new(@path)
      end

      def finalize
        @socket.close
      end

      def request(request : BaseRequest, result_type : ResultT.class) forall ResultT
        request.id = @@id

        @socket.puts request.to_json
        @@id += 1
        json = @socket.gets

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
    end
  end
end
