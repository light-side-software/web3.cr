require "json"

require "./base_request"

module Web3::Models
  class ParamsRequest(ParamType) < BaseRequest
    JSON.mapping({
      jsonrpc: {type: String, nilable: false, getter: false, setter: false},
      id: {type: Int32, nilable: false, getter: false, setter: false},
      method: {type: String, nilable: false, getter: false, setter: false},
      params: {type: Array(ParamType), nilable: false},
    })

    def initialize(@method : String, @params : Array(ParamType) = [] of ParamType, @jsonrpc : String = RpcClient::JSONRPC_VERSION, @id = 1)
    end
  end
end
