require "big"
require "json"

require "./base_request"
require "../converters/big_int/hex_string_converter"

module Web3::Models
  class CallObject
    JSON.mapping({
      data: {type: String, nilable: true},
      from: {type: String, nilable: true},
      gas: {type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      gas_price: {key: "gasPrice", type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      to: {type: String, nilable: true},
      value: {type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
    })

    def initialize(@to : String? = nil, @from : String? = nil, @gas : BigInt? = nil,
      @gas_price : BigInt? = nil, @value : BigInt? = nil, @data : String? = nil)
    end
  end

  class CallRequest < BaseRequest
    JSON.mapping({
      jsonrpc: {type: String, nilable: false, getter: false, setter: false},
      id: {type: Int32, nilable: false, getter: false, setter: false},
      method: {type: String, nilable: false, getter: false, setter: false},
      params: {type: Array(CallObject | String), nilable: false, getter: false, setter: false},
    })

    def initialize(@method : String, call : CallObject, block : (Int | BigInt | String | Symbol) = "latest", @jsonrpc : String = JSONRPC_VERSION, @id = 1)
      @params = [call, block.to_block_param]
    end
  end
end
