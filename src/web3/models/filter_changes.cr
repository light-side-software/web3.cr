require "big"
require "json"

require "../converters/big_int/hex_string_converter"

module Web3::Models
  class FilterChanges
    JSON.mapping({
      removed: {type: Bool, nilable: true},
      log_index: {key: "logIndex", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      transaction_index: {key: "transactionIndex", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      transaction_hash: {key: "transactionHash", type: String, nilable: false},
      block_hash: {key: "blockHash", type: String, nilable: false},
      block_number: {key: "blockNumber", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      address: {type: String, nilable: false},
      data: {type: String, nilable: false},
      topics: {type: Array(String), nilable: true},
    })
  end
end
