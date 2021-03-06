require "json"

require "./base_response"

module Web3::Models
  class ResultResponse(ResultType) < BaseResponse
    JSON.mapping({
      jsonrpc: {type: String, nilable: false, getter: false, setter: false},
      id: {type: Int32, nilable: false, getter: false, setter: false},
      result: {type: ResultType, nilable: false},
    })
  end

  alias NullResultResponse = ResultResponse(Nil)
end
