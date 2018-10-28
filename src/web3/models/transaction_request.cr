require "big"
require "json"

require "./base_request"
require "../converters/big_int/hex_string_converter"

module Web3::Models
  class TransactionObject
    JSON.mapping({
      data: {type: String, nilable: false},
      from: {type: String, nilable: false},
      gas: {type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      gas_price: {key: "gasPrice", type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      nonce: {type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      to: {type: String, nilable: true},
      value: {type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
    })

    def initialize(@from : String, @to : String?, @gas : BigInt?,
      @gas_price : BigInt?, @value : BigInt?, @data : String, @nonce : BigInt?)
    end
  end

  class TransactionRequest < BaseRequest
    JSON.mapping({
      jsonrpc: {type: String, nilable: false, getter: false, setter: false},
      id: {type: Int32, nilable: false, getter: false, setter: false},
      method: {type: String, nilable: false, getter: false, setter: false},
      params: {type: Array(TransactionObject), nilable: false, getter: false, setter: false},
    })

    def initialize(@method : String, transaction : TransactionObject, @jsonrpc : String = JSONRPC_VERSION, @id = 1)
      @params = [transaction]
    end

    def transaction : TransactionObject
      @params[0]
    end

    def transaction=(object : TransactionObject)
      @params[0] = object
    end
  end
end
