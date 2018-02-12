require "./rpc_client"
require "./models/*"

module Web3
  include Models

  class Net
    def initialize(@rpc : RpcClient)
    end

    def version
      @rpc.request BaseRequest.new("net_version"), ResultResponse(String)
    end

    def listening
      @rpc.request BaseRequest.new("net_listening"), ResultResponse(Bool)
    end

    def peer_count
      @rpc.request BaseRequest.new("net_peerCount"), BigIntResponse
    end
  end
end
