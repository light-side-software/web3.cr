require "big"
require "json"

require "../converters/big_int/hex_string_converter"

module Web3::Models
  class Block
    JSON.mapping({
      number: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      hash: {type: String, nilable: false},
      parent_hash: {key: "parentHash", type: String, nilable: false},
      nonce: {type: String, nilable: false},
      sha3_uncled: {key: "sha3Uncles", type: String, nilable: false},
      logs_bloom: {key: "logsBloom", type: String, nilable: false},
      transactions_root: {key: "transactionsRoot", type: String, nilable: false},
      state_root: {key: "stateRoot", type: String, nilable: false},
      miner: {type: String, nilable: false},
      difficulty: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      total_difficulty: {key: "totalDifficulty", type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      extra_data: {key: "extraData", type: String, nilable: false},
      size: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      gas_limit: {key: "gasLimit", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      gas_used: {key: "gasUsed", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      timestamp: {type: String, nilable: false}, # TODO: convert to UInt32
      transactions: {type: Array(String), nilable: true}, # TODO: Array(String | Transaction)
      uncles: {type: Array(String), nilable: false}, # TODO: Array(String | Uncle)
    })
  end
end
