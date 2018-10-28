require "./helpers/*"
require "./exceptions/*"
require "./models/base_request"
require "./providers/base_provider"

module Web3
  class Eth
    include Helpers
    include Models
    include Exceptions
    include Providers

    def initialize(@rpc : BaseProvider)
    end

    def protocol_version : String
      @rpc.request BaseRequest.new("eth_protocolVersion"), ResultResponse(String)
    end

    def syncing : (SyncingResult | Bool)
      @rpc.request BaseRequest.new("eth_syncing"), ResultResponse(SyncingResult | Bool)
    end

    def coinbase : String
      @rpc.request BaseRequest.new("eth_coinbase"), ResultResponse(String)
    end

    def mining : Bool
      @rpc.request BaseRequest.new("eth_mining"), ResultResponse(Bool)
    end

    def hashrate : BigInt
      @rpc.request BaseRequest.new("eth_hashrate"), BigIntResponse
    end

    def gas_price : BigInt
      @rpc.request BaseRequest.new("eth_gasPrice"), BigIntResponse
    end

    def accounts : Array(String)
      @rpc.request BaseRequest.new("eth_accounts"), ResultResponse(Array(String))
    end

    def block_number : BigInt
      @rpc.request BaseRequest.new("eth_blockNumber"), BigIntResponse
    end

    def get_balance(address : String, block : (Int | BigInt | String | Symbol) = "latest")
      @rpc.request ParamsRequest(String).new("eth_getBalance", [address, block.to_block_param]), BigIntResponse
    end

    def get_storage_at(address : String, position : (Int | BigInt), block : (Int | BigInt | String | Symbol) = "latest") : String
      @rpc.request ParamsRequest(String).new("eth_getStorageAt", [address, "0x" + position.to_s(16), block.to_block_param]), ResultResponse(String)
    end

    def get_transaction_count(address : String, block : (Int | BigInt | String | Symbol) = "latest") : BigInt
      @rpc.request ParamsRequest(String).new("eth_getTransactionCount", [address, block.to_block_param]), BigIntResponse
    end

    def get_block_transaction_count_by_hash(block_hash : String) : BigInt
      @rpc.request ParamsRequest(String).new("eth_getBlockTransactionCountByHash", [block_hash]), BigIntResponse
    end

    def get_block_transaction_count_by_number(block_number : (Int | BigInt)) : BigInt
      @rpc.request ParamsRequest(String).new("eth_getBlockTransactionCountByNumber", ["0x" + block_number.to_s(16)]), BigIntResponse
    end

    def get_uncle_count_by_block_hash(block_hash : String) : BigInt
      @rpc.request ParamsRequest(String).new("eth_getUncleCountByBlockHash", [block_hash]), BigIntResponse
    end

    def get_uncle_count_by_block_number(block_number : (Int | BigInt)) : BigInt
      @rpc.request ParamsRequest(String).new("eth_getUncleCountByBlockNumber", ["0x" + block_number.to_s(16)]), BigIntResponse
    end

    def get_code(address : String, block : (Int | BigInt | String | Symbol) = "latest") : String
      @rpc.request ParamsRequest(String).new("eth_getCode", [address, block.to_block_param]), ResultResponse(String)
    end

    def sign(address : String, data : String) : String
      @rpc.request ParamsRequest(String).new("eth_sign", [address, data]), ResultResponse(String)
    end

    def send_transaction(from : String, data : String, to : String? = nil, gas : BigInt? = 9000.to_big_i,
        gas_price : BigInt? = nil, value : BigInt? = nil, nonce : BigInt? = nil) : String
      transaction = TransactionObject.new(from, to, gas, gas_price, value, data, nonce)
      @rpc.request TransactionRequest.new("eth_sendTransaction", transaction), ResultResponse(String)
    end

    def send_raw_transaction(data : String) : String
      @rpc.request ParamsRequest(String).new("eth_sendRawTransaction", [data]), ResultResponse(String)
    end

    def call(to : String, from : String? = nil, data : String? = nil, gas : BigInt? = nil,
        gas_price : BigInt? = nil, value : BigInt? = nil, block : (Int | BigInt | String | Symbol) = "latest") : String
      transaction = CallObject.new(to, from, gas, gas_price, value, data)
      @rpc.request CallRequest.new("eth_call", transaction, block), ResultResponse(String)
    end

    def estimate_gas(to : String? = nil, from : String? = nil, data : String? = nil, gas : BigInt? = nil,
        gas_price : BigInt? = nil, value : BigInt? = nil) : BigInt
      transaction = CallObject.new(to, from, gas, gas_price, value, data)
      @rpc.request ParamsRequest(CallObject).new("eth_estimateGas", [transaction]), BigIntResponse
    end

    def get_block_by_hash(hash : String, full_object : Bool = false) : Block
      @rpc.request ParamsRequest(String | Bool).new("eth_getBlockByHash", [hash, full_object]), ResultResponse(Block)
    end

    def get_block_by_number(block : (Int | BigInt | String | Symbol), full_object = false) : Block
      @rpc.request ParamsRequest(String | Bool).new("eth_getBlockByNumber", [block.to_block_param, full_object]), ResultResponse(Block)
    end

    def get_transaction_by_hash(hash : String) : Transaction
      @rpc.request ParamsRequest(String).new("eth_getTransactionByHash", [hash]), ResultResponse(Transaction)
    end

    def get_transaction_by_block_hash_and_index(block_hash : String, index : (Int | BigInt)) : Transaction
      @rpc.request ParamsRequest(String).new("eth_getTransactionByBlockHashAndIndex", [block_hash, index.to_block_param]), ResultResponse(Transaction)
    end

    def get_transaction_by_block_number_and_index(block : (Int | BigInt | String | Symbol), index : (Int | BigInt)) : Transaction
      @rpc.request ParamsRequest(String).new("eth_getTransactionByBlockNumberAndIndex", [block.to_block_param, index.to_block_param]), ResultResponse(Transaction)
    end

    def get_transaction_receipt(hash : String) : TransactionReceipt
      @rpc.request ParamsRequest(String).new("eth_getTransactionReceipt", [hash]), ResultResponse(TransactionReceipt)
    end

    def get_uncle_by_block_hash_and_index(block_hash : String, index : (Int | BigInt)) : Block
      @rpc.request ParamsRequest(String).new("eth_getUncleByBlockHashAndIndex", [block_hash, index.to_block_param]), ResultResponse(Block)
    end

    def get_uncle_by_block_number_and_index(block : (Int | BigInt | String | Symbol), index : (Int | BigInt)) : Block
      @rpc.request ParamsRequest(String).new("eth_getUncleByBlockNumberAndIndex", [block.to_block_param, index.to_block_param]), ResultResponse(Block)
    end

    def new_filter(from_block : (Int | BigInt | String | Symbol)? = "latest", to_block : (Int | BigInt | String | Symbol) = "latest",
        address : (String | Array(String))? = nil, topics : (Array(String | Array(String) | Nil)) = [] of Nil, limit : (Int | BigInt)? = nil) : BigInt
      filter = FilterObject.new(from_block, to_block, address, topics, limit)
      @rpc.request ParamsRequest(FilterObject).new("eth_newFilter", [filter]), BigIntResponse
    end

    def new_block_filter : BigInt
      @rpc.request BaseRequest.new("eth_newBlockFilter"), BigIntResponse
    end

    def new_pending_transaction_filter : BigInt
      @rpc.request BaseRequest.new("eth_newPendingTransactionFilter"), BigIntResponse
    end

    def uninstall_filter(id : (Int | BigInt)) : Bool
      @rpc.request ParamsRequest.new("eth_uninstallFilter", [id.to_block_param]), ResultResponse(Bool)
    end

    def get_filter_changes(filter_id : (Int | BigInt)) : Array(FilterChanges | String)
      @rpc.request ParamsRequest.new("eth_getFilterChanges", [filter_id.to_block_param]), ResultResponse(Array(FilterChanges | String))
    end

    def get_filter_logs(filter_id : (Int | BigInt)) : Array(FilterChanges | String)
      @rpc.request ParamsRequest.new("eth_getFilterLogs", [filter_id.to_block_param]), ResultResponse(Array(FilterChanges | String))
    end

    def get_logs(from_block : (BigInt | String)? = nil, to_block : (BigInt | String)? = nil,
        address : (String | Array(String) | Nil) = nil, topics : (Array(String | Array(String) | Nil)) = nil) : Array(FilterChanges | String)
      filter = FilterObject.new(from_block, to_block, address, topics)
      @rpc.request ParamsRequest(FilterObject).new("eth_newFilter", [filter]), ResultResponse(Array(FilterChanges | String))
    end

    def get_work : Array(String)
      @rpc.request BaseRequest.new("eth_getWork"), ResultResponse(Array(String))
    end

    def submit_work(nonce : String, header_pow_hash : String, mix_digest : String) : Bool
      @rpc.request ParamsRequest(String).new("eth_submitWork", [nonce, header_pow_hash, mix_digest]), ResultResponse(Bool)
    end

    def submit_hashrate(hashrate : String, id : String) : Bool
      @rpc.request ParamsRequest(String).new("eth_submitHashrate", [hashrate, id]), ResultResponse(Bool)
    end
  end
end
