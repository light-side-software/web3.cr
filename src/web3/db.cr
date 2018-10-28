require "./models/*"
require "./providers/base_provider"

module Web3
  include Models
    include Providers

  class Db
    def initialize(@provider : BaseProvider)
    end

    def put_string(db_name : String, key : String, value : String)
      @provider.request ParamsRequest(String).new("db_putString", [db_name, key, value]), ResultResponse(Bool)
    end

    def get_string(db_name : String, key : String)
      @provider.request ParamsRequest(String).new("db_getString", [db_name, key]), ResultResponse(String)
    end

    def put_hex(db_name : String, key : String, data : (Bytes | String))
      data_string = case data
        when Bytes then "0x" + data.as(Bytes).hexstring
        else data.as(String)
      end
      @provider.request ParamsRequest(String).new("db_putHex", [db_name, key, data_string]), ResultResponse(Bool)
    end

    def get_hex(db_name : String, key : String)
      @provider.request ParamsRequest(String).new("db_getHex", [db_name, key]), ResultResponse(String)
    end
  end
end
