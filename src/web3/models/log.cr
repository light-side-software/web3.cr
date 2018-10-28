require "json"

require "../converters/big_int/hex_string_converter"

module Web3::Models
  class Log
    JSON.mapping({
      address: {type: String, nilable: false},
      block_hash: {key: "blockHash", type: String, nilable: true},
      block_number: {key: "blockNumber", type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      data: {type: String, nilable: false},
      log_index: {key: "logIndex", type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      removed: {type: Bool, nilable: false},
      topics: {type: Array(String), nilable: false},
      transaction_hash: {key: "transactionHash", type: String, nilable: true},
      transaction_index: {key: "transactionIndex", type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      transaction_log_index: {key: "transactionLogIndex", type: BigInt, nilable: true, converter: BigInt::HexStringConverter}, # parity only
      type: {type: String, nilable: true},
    })
  end
end
