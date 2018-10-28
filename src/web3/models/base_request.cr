require "json"

require "../providers/base_provider"

module Web3::Models
  class BaseRequest
    JSONRPC_VERSION = "2.0"

    JSON.mapping({
      jsonrpc: {type: String, nilable: false},
      id: {type: Int32, nilable: false},
      method: {type: String, nilable: false},
    })

    def initialize(@method : String, @jsonrpc : String = JSONRPC_VERSION, @id = 1)
    end
  end
end
