require "./models/*"
require "./providers/base_provider"

module Web3
  include Models
  include Providers

  class Net
    def initialize(@provider : BaseProvider)
    end

    def version
      @provider.request BaseRequest.new("net_version"), ResultResponse(String)
    end

    def listening
      @provider.request BaseRequest.new("net_listening"), ResultResponse(Bool)
    end

    def peer_count
      @provider.request BaseRequest.new("net_peerCount"), BigIntResponse
    end
  end
end
