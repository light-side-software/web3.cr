require "json"

require "../rpc_client"

module Web3::Models
  class BaseRequest
    JSON.mapping({
      jsonrpc: {type: String, nilable: false},
      id: {type: Int32, nilable: false},
      method: {type: String, nilable: false},
    })

    def initialize(@method : String, @jsonrpc : String = RpcClient::JSONRPC_VERSION, @id = 1)
    end
  end
end
