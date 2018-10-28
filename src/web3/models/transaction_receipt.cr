require "json"

require "../converters/big_int/hex_string_converter"

module Web3::Models
  class TransactionReceipt
    JSON.mapping({
      block_hash: {key: "blockHash", type: String, nilable: false},
      block_number: {key: "blockNumber", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      contract_address: {key: "contractAddress", type: String, nilable: true},
      cumulative_gas_used: {key: "cumulativeGasUsed", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      from: {type: String, nilable: false},
      gas_used: {key: "gasUsed", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      logs: {type: Array(String), nilable: false}, # TODO: Array(Log)
      logs_bloom: {key: "logsBloom", type: String, nilable: false},
      root: {type: String, nilable: true},
      status: {type: BigInt, nilable: true, converter: BigInt::HexStringConverter},
      to: {type: String, nilable: true},
      transaction_hash: {key: "transactionHash", type: String, nilable: false},
      transaction_index: {key: "transactionIndex", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
    })
  end
end
