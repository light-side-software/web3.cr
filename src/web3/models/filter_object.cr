require "big"
require "json"

require "../converters/big_int/hex_string_converter"

module Web3::Models
  class FilterObject
    JSON.mapping({
      address: {type: (String | Array(String)), nilable: true},
      blockhash: {type: String, nilable: true},
      from_block: {key: "fromBlock", type: String, nilable: true},
      limit: {type: BigInt, nilable: true, converter: BigInt::HexStringConverter}, # parity only
      topics: {type: Array(String | Array(String) | Nil), nilable: true},
      to_block: {key: "toBlock", type: String, nilable: true},
    })

    def initialize(from_block : (Int | BigInt | String | Symbol)? = "latest", to_block : (Int | BigInt | String | Symbol) = "latest",
        @address : (String | Array(String))? = nil, @topics : (Array(String | Array(String) | Nil)) = [] of Nil,
        limit : (Int | BigInt)? = nil, @blockhash : String? = nil)
      @from_block = from_block.to_block_param
      @to_block = to_block.to_block_param
      @limit = limit.is_a?(Nil) ? nil : limit.to_big_i
    end
  end
end
