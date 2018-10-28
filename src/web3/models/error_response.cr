require "json"

require "./base_response"
require "./error"

module Web3::Models
  class ErrorResponse < BaseResponse
    JSON.mapping({
      jsonrpc: {type: String, nilable: false, getter: false, setter: false},
      id: {type: Int32, nilable: false, getter: false, setter: false},
      error: {type: Error, nilable: false},
    })

    def initialize(message : String)
      @jsonrpc = ""
      @id = 0
      @error = Error.new(code: 0, message: message)
    end
  end
end
