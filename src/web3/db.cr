require "./rpc_client"
require "./models/*"

module Web3
  include Models

  class Db
    def initialize(@rpc : RpcClient)
    end

    def put_string(db_name : String, key : String, value : String)
      @rpc.request ParamsRequest(String).new("db_putString", [db_name, key, value]), ResultResponse(Bool)
    end

    def get_string(db_name : String, key : String)
      @rpc.request ParamsRequest(String).new("db_getString", [db_name, key]), ResultResponse(String)
    end

    def put_hex(db_name : String, key : String, data : (Bytes | String))
      data_string = case data
        when Bytes then "0x" + data.as(Bytes).hexstring
        else data.as(String)
      end
      @rpc.request ParamsRequest(String).new("db_putHex", [db_name, key, data_string]), ResultResponse(Bool)
    end

    def get_hex(db_name : String, key : String)
      @rpc.request ParamsRequest(String).new("db_getHex", [db_name, key]), ResultResponse(String)
    end
  end
end
