require "big"
require "json"

require "../converters/big_int/hex_string_converter"

module Web3::Models
  class Block
    JSON.mapping({
      author: {type: String, nilable: true}, # parity only
      difficulty: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      extra_data: {key: "extraData", type: String, nilable: false},
      gas_limit: {key: "gasLimit", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      gas_used: {key: "gasUsed", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      hash: {type: String, nilable: true},
      logs_bloom: {key: "logsBloom", type: String, nilable: true},
      miner: {type: String, nilable: false},
      nonce: {type: String, nilable: true},
      number: {type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      parent_hash: {key: "parentHash", type: String, nilable: false},
      receipts_root: {key: "receiptsRoot", type: String, nilable: false},
      seal_fields: {key: "sealFields", type: Array(String), nilable: true}, # parity only
      sha3_uncles: {key: "sha3Uncles", type: String, nilable: false},
      size: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      state_root: {key: "stateRoot", type: String, nilable: false},
      timestamp: {type: String, nilable: false}, # TODO: convert to UInt32
      total_difficulty: {key: "totalDifficulty", type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      transactions: {type: Array(String | Transaction), nilable: false}, # TODO: Array(String | Transaction)
      transactions_root: {key: "transactionsRoot", type: String, nilable: false},
      uncles: {type: Array(String), nilable: false}, # TODO: Array(String | Uncle)
    })

    def initialize
      @author = nil
      @difficulty = 0.to_big_i
      @extra_data = "0x0"
      @gas_limit = 0.to_big_i
      @gas_used = 0.to_big_i
      @hash = ""
      @logs_bloom = ""
      @miner = ""
      @nonce = nil
      @number = -1.to_big_i
      @parent_hash = ""
      @receipts_root = ""
      @seal_fields = nil
      @sha3_uncles = ""
      @size = 0.to_big_i
      @state_root = ""
      @timestamp = ""
      @total_difficulty = 0.to_big_i
      @transactions = [] of (String | Transaction)
      @transactions_root = ""
      @uncles = [] of String
    end

  end
end
