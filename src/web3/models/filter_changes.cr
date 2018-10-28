require "big"
require "json"

require "../converters/big_int/hex_string_converter"

module Web3::Models
  class FilterChanges
    JSON.mapping({
      address: {type: String, nilable: false},
      block_hash: {key: "blockHash", type: String, nilable: false},
      block_number: {key: "blockNumber", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      data: {type: String, nilable: false},
      log_index: {key: "logIndex", type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      removed: {type: Bool, nilable: true},
      topics: {type: Array(String), nilable: true},
      transaction_hash: {key: "transactionHash", type: String, nilable: false},
      transaction_index: {key: "transactionIndex", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
    })
  end
end
