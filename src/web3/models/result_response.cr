require "http/client"
require "json"

require "./base_response"
require "./error"

module Web3::Models
  class ResultResponse(ResultType) < BaseResponse
    JSON.mapping({
      jsonrpc: {type: String, nilable: false, getter: false, setter: false},
      id: {type: Int32, nilable: false, getter: false, setter: false},
      error: {type: Error?, nilable: true, getter: false, setter: false},
      result: {type: ResultType, nilable: true},
    })
  end
end
