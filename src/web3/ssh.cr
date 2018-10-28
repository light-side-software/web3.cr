require "./models/*"
require "./providers/base_provider"

module Web3
  include Models
    include Providers

  class Ssh
    def initialize(@provider : BaseProvider)
    end

    def version
      @provider.request BaseRequest.new("ssh_version"), ResultResponse(String)
    end
  end
end
