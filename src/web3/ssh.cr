require "./rpc_client"
require "./models/*"

module Web3
  include Models

  class Ssh
    def initialize(@rpc : RpcClient)
    end

    def version
      @rpc.request BaseRequest.new("ssh_version"), ResultResponse(String)
    end

    def post
    end
  end
end
