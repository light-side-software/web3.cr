require "big"
require "json"

require "../converters/big_int/hex_string_converter"

module Web3::Models
  class FilterObject
    JSON.mapping({
      from_block: {key: "fromBlock", type: String, nilable: true},
      to_block: {key: "toBlock", type: String, nilable: true},
      address: {type: (String | Array(String)), nilable: true},
      topics: {type: Array(String | Array(String) | Nil), nilable: true},
    })
  end
end
