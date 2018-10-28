require "../models/error_response"
require "../models/error"

module Web3::Exceptions
  class ErrorResponseException < Exception
    property response : ErrorResponse

    def initialize(@response : ErrorResponse)
      super @response.error.message
    end

    def error : Error
      response.error
    end

    def code : Int32
      error.code
    end
  end
end
