require "json"

require "../converters/big_int/hex_string_converter"

module Web3::Models
  class Transaction
    JSON.mapping({
      hash: {type: String, nilable: false},
      nonce: {type: String, nilable: false},
      block_hash: {key: "blockHash", type: String, nilable: false},
      block_number: {key: "blockNumber", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      transaction_index: {key: "transactionIndex", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      from: {type: String, nilable: false},
      to: {type: String, nilable: false},
      value: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      gas: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      gas_price: {key: "gasPrice", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      input: {type: String, nilable: false},
      v: {type: String, nilable: true},
      r: {type: String, nilable: true},
      s: {type: String, nilable: true},
    })
  end
end
