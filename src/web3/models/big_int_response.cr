require "http/client"
require "json"

require "./base_response"
require "./error"
require "../converters/big_int/hex_string_converter"

module Web3::Models
  class BigIntResponse < BaseResponse
    JSON.mapping({
      jsonrpc: {type: String, nilable: false, getter: false, setter: false},
      id: {type: Int32, nilable: false, getter: false, setter: false},
      error: {type: Error?, nilable: true, getter: false, setter: false},
      result: {type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
    })
  end
end
