require "json"

require "./result_response"
require "../converters/big_int/hex_string_converter"

module Web3::Models
  class SyncingResult
    JSON.mapping({
      starting_block: {key: "startingBlock", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      current_block: {key: "currentBlock", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      highest_block: {key: "highestBlock", type: BigInt, nilable: false, converter: BigInt::HexStringConverter},
      known_states: {key: "knownStates", type: BigInt?, nilable: true, converter: BigInt::HexStringConverter},
      pulled_states: {key: "pulledStates", type: BigInt?, nilable: true, converter: BigInt::HexStringConverter},
    })
  end

  class SyncingResponse < ResultResponse(SyncingResult | Bool | Nil)
  end
end
