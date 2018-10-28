require "json"

require "../converters/big_int/hex_string_converter"

module Web3::Models
  class Transaction
    JSON.mapping({
      block_hash: {key: "blockHash", type: String, nilable: false},
      block_number: {key: "blockNumber", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      chain_id: {key: "chainId", type: BigInt, nilable: true, converter: BigInt::HexStringConverter}, # parity only
      creates: {type: String, nilable: true},
      from: {type: String, nilable: false},
      gas: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      gas_price: {key: "gasPrice", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      hash: {type: String, nilable: false},
      input: {type: String, nilable: false},
      network_id: {key: "networkId", type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      nonce: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      public_key: {key: "publicKey", type: String, nilable: true}, # parity only
      r: {type: String, nilable: false},
      raw: {type: String, nilable: true}, # parity only
      s: {type: String, nilable: false},
      standard_v: {key: "standardV", type: String, nilable: true}, # parity only
      to: {type: String, nilable: false},
      transaction_index: {key: "transactionIndex", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      v: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      value: {type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
    })
  end
end
