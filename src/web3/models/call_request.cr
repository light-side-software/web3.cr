require "big"
require "json"

require "./base_request"
require "../converters/big_int/hex_string_converter"

module Web3::Models
  class CallObject
    JSON.mapping({
      from: {type: String, nilable: true},
      to: {type: String, nilable: true},
      gas: {type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      gas_price: {key: "gasPrice", type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      value: {type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      data: {type: String, nilable: true},
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

    def initialize(@method : String, call : CallObject, block : (BigInt | String) = "latest", @jsonrpc : String = RpcClient::JSONRPC_VERSION, @id = 1)
      block_string = case block
        when BigInt then "0x" + block.as(BigInt).to_s(16)
        when String then block.as(String)
        else "latest"
      end
      @params = [call, block_string]
    end

    def call : CallObject
      @params[0]
    end

    def call=(object : CallObject)
      @params[0] = object
    end

    def block : String
      @params[1]
    end

    def block=(block : (BigInt | String))
      block_string = case block
        when BigInt then "0x" + block.as(BigInt).to_s(16)
        when String then block.as(String)
        else "latest"
      end
      @params[1] = block_string
    end
  end
end
