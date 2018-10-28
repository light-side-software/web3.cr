require "./db"
require "./eth"
require "./net"
require "./ssh"
require "./models/base_request"
require "./models/params_request"
require "./models/result_response"
require "./providers/base_provider"

module Web3
  include Models
  include Providers

  getter provider : BaseProvider

  class Client
    def initialize(@provider : BaseProvider)
      # @db = Db.new(@provider)
      @eth = Eth.new(@provider)
      # @net = Net.new(@provider)
      # @ssh = Ssh.new(@provider)
    end

    # def db : Db
    #   @db
    # end

    def eth : Eth
      @eth
    end

    # def net : Net
    #   @net
    # end

    # def ssh : Ssh
    #   @ssh
    # end

    def client_version : String
      @provider.request BaseRequest.new("web3_clientVersion"), ResultResponse(String)
    end

    def sha3(data : Bytes | String) : String
      @provider.request ParamsRequest(String).new("web3_sha3", [data.to_hex_param]), ResultResponse(String)
    end
  end
end
