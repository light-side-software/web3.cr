require "./eth"
require "./net"
require "./rpc_client"
require "./models/*"

module Web3
  include Models

  getter url : String

  class Client
    def initialize(@url : String)
      @rpc = RpcClient.new(@url)
      @db = Db.new(@rpc)
      @eth = Eth.new(@rpc)
      @net = Net.new(@rpc)
      @ssh = Ssh.new(@rpc)
    end

    def db : Db
      @db
    end

    def eth : Eth
      @eth
    end

    def net : Net
      @net
    end

    def ssh : Ssh
      @ssh
    end

    def client_version
      @rpc.request BaseRequest.new("web3_clientVersion"), ResultResponse(String)
    end

    def sha3(data : Bytes | String)
      string_data = case data
        when Bytes then "0x" + data.as(Bytes).hexstring
        when String then data.as(String)
      end
      @rpc.request ParamsRequest(String).new("web3_sha3", [data.as(String)]), ResultResponse(String)
    end
  end
end
