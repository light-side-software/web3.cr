require "big"
require "http/client"
require "json"

require "./result_response"
require "../converters/big_int/hex_string_converter"

module Web3::Models
  class BigIntResponse < ResultResponse(BigInt)
    JSON.mapping({
      jsonrpc: {type: String, nilable: false, getter: false, setter: false},
      id: {type: Int32, nilable: false, getter: false, setter: false},
      result: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
    })
  end
end
