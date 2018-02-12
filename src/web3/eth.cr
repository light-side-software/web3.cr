require "./rpc_client"
require "./helpers/*"
require "./models/*"

module Web3
  class Eth
    include Helpers
    include Models

    def initialize(@rpc : RpcClient)
    end

    def protocol_version
      @rpc.request BaseRequest.new("eth_protocolVersion"), ResultResponse(String)
    end

    def syncing
      @rpc.request BaseRequest.new("eth_syncing"), SyncingResponse
    end

    def coinbase
      @rpc.request BaseRequest.new("eth_coinbase"), ResultResponse(String)
    end

    def mining
      @rpc.request BaseRequest.new("eth_mining"), ResultResponse(Bool)
    end

    def hashrate
      @rpc.request BaseRequest.new("eth_hashrate"), BigIntResponse
    end

    def gas_price
      @rpc.request BaseRequest.new("eth_gasPrice"), BigIntResponse
    end

    def accounts
      @rpc.request BaseRequest.new("eth_accounts"), ResultResponse(Array(String))
    end

    def block_number
      @rpc.request BaseRequest.new("eth_blockNumber"), BigIntResponse
    end

    def get_balance(address : String, block : (BigInt | String) = "latest")
      @rpc.request ParamsRequest(String).new("eth_getBalance", [address, Formatter.block_string(block)]), BigIntResponse
    end

    def get_storage_at(address : String, position : BigInt, block : (BigInt | String) = "latest")
      @rpc.request ParamsRequest(String).new("eth_getStorateAt", [address, "0x" + position.to_s(16), Formatter.block_string(block)]), ResultResponse(String)
    end

    def get_transaction_count(address : String, block : (BigInt | String) = "latest")
      @rpc.request ParamsRequest(String).new("eth_getTransactionCount", [address, Formatter.block_string(block)]), BigIntResponse
    end

    def get_block_transaction_count_by_hash(block_hash : String)
      @rpc.request ParamsRequest(String).new("eth_getBlockTransactionCountByHash", [block_hash]), BigIntResponse
    end

    def get_block_transaction_count_by_number(block_number : BigInt)
      @rpc.request ParamsRequest(String).new("eth_getBlockTransactionCountByNumber", ["0x" + block_number.to_s(16)]), BigIntResponse
    end

    def get_uncle_count_by_block_hash(block_hash : String)
      @rpc.request ParamsRequest(String).new("eth_getUncleCountByBlockHash", [block_hash]), BigIntResponse
    end

    def get_uncle_count_by_block_number(block_number : BigInt)
      @rpc.request ParamsRequest(String).new("eth_getUncleCountByBlockNumber", ["0x" + block_number.to_s(16)]), BigIntResponse
    end

    def get_code(address : String, block : (BigInt | String) = "latest")
      @rpc.request ParamsRequest(String).new("eth_getCode", [address, Formatter.block_string(block)]), ResultResponse(String)
    end

    def sign(address : String, data : String)
      @rpc.request ParamsRequest(String).new("eth_sign", [address, data]), ResultResponse(String)
    end

    def send_transaction(from : String, data : String, to : String? = nil, gas : BigInt? = nil,
        gas_price : BigInt? = nil, value : BigInt? = nil, nonce : BigInt? = nil)
      transaction = TransactionObject.new(from, to, gas, gas_price, value, data, nonce)
      @rpc.request TransactionRequest.new("eth_sendTransaction", transaction), ResultResponse(String)
    end

    def send_raw_transaction(data : String)
      @rpc.request ParamsRequest(String).new("eth_sendRawTransaction", [data]), ResultResponse(String)
    end

    def call(to : String, from : String? = nil, data : String? = nil, gas : BigInt? = nil,
        gas_price : BigInt? = nil, value : BigInt? = nil, block : (BigInt | String) = "latest")
      transaction = CallObject.new(to, from, gas, gas_price, value, data)
      @rpc.request CallRequest.new("eth_call", transaction, Formatter.block_string(block)), ResultResponse(String)
    end

    def estimate_gas(to : String? = nil, from : String? = nil, data : String? = nil, gas : BigInt? = nil,
        gas_price : BigInt? = nil, value : BigInt? = nil)
      transaction = CallObject.new(to, from, gas, gas_price, value, data)
      @rpc.request ParamsRequest(CallObject).new("eth_estimateGas", [transaction]), BigIntResponse
    end

    def get_block_by_hash(hash : String, full_object = false)
      @rpc.request ParamsRequest(String | Bool).new("eth_getBlockByHash", [hash, full_object]), ResultResponse(Block)
    end

    def get_block_by_number(block : (BigInt | String), full_object = false)
      @rpc.request ParamsRequest(String | Bool).new("eth_getBlockByNumber", [Formatter.block_string(block), full_object]), ResultResponse(Block)
    end

    def get_transaction_by_hash(hash : String)
      @rpc.request ParamsRequest(String).new("eth_getTransactionByHash", [hash]), ResultResponse(Transaction)
    end

    def get_transaction_by_block_hash_and_index(block_hash : String, index : BigInt)
      @rpc.request ParamsRequest(String).new("eth_getTransactionByBlockHashAndIndex", [block_hash, "0x" + index.to_s(16)]), ResultResponse(Transaction)
    end

    def get_transaction_by_block_number_and_index(block : (BigInt | String), index : BigInt)
      @rpc.request ParamsRequest(String).new("eth_getTransactionByBlockNumberAndIndex", [Formatter.block_string(block), "0x" + index.to_s(16)]), ResultResponse(Transaction)
    end

    def get_transaction_receipt(hash : String)
      @rpc.request ParamsRequest(String).new("eth_getTransactionReceipt", [hash]), ResultResponse(TransactionReceipt)
    end

    def get_uncle_by_block_hash_and_index(block_hash : String, index : BigInt)
      @rpc.request ParamsRequest(String).new("eth_getUncleByBlockHashAndIndex", [block_hash, "0x" + index.to_s(16)]), ResultResponse(Block)
    end

    def get_uncle_by_block_number_and_index(block : (BigInt | String), index : BigInt)
      @rpc.request ParamsRequest(String).new("eth_getUncleByBlockNumberAndIndex", [Formatter.block_string(block), "0x" + index.to_s(16)]), ResultResponse(Block)
    end

    def get_compilers
      @rpc.request BaseRequest.new("eth_getCompilers"), ResultResponse(Array(String))
    end

    # def compile_solidity(source : String)
    #   @rpc.request ParamsRequest(String).new("eth_compileSolidity", [source]), ResultResponse(SolidityData)
    # end

    # def compile_lll(source : String)
    #   @rpc.request ParamsRequest(String).new("eth_compileLLL", [source]), ResultResponse(String)
    # end

    # def compile_serpent(source : String)
    #   @rpc.request ParamsRequest(String).new("eth_compileSerpent", [source]), ResultResponse(String)
    # end

    def new_filter(from_block : (BigInt | String)? = nil, to_block : (BigInt | String)? = nil,
        address : (String | Array(String) | Nil) = nil, topics : (Array(String | Array(String) | Nil)) = nil)
      filter = FilterObject.new(from_block, to_block, address, topics)
      @rpc.request ParamsRequest(FilterObject).new("eth_newFilter", [filter]), BigIntResponse
    end

    def new_block_filter
      @rpc.request BaseRequest.new("eth_newBlockFilter"), BigIntResponse
    end

    def new_pending_transaction_filter
      @rpc.request BaseRequest.new("eth_newPendingTransactionFilter"), BigIntResponse
    end

    def uninstall_filter(id : BigInt)
      @rpc.request BaseRequest.new("eth_uninstallFilter", ["0x" + id.to_s(16)]), ResultResponse(Bool)
    end

    def get_filter_changes(filter_id : BigInt)
      @rpc.request ParamsRequest.new("eth_getFilterChanges", ["0x" + filter_id.to_s(16)]), ResultResponse(Array(FilterChanges | String))
    end

    def get_filter_logs(filter_id : BigInt)
      @rpc.request ParamsRequest.new("eth_getFilterLogs", ["0x" + filter_id.to_s(16)]), ResultResponse(Array(FilterChanges | String))
    end

    def get_logs(from_block : (BigInt | String)? = nil, to_block : (BigInt | String)? = nil,
        address : (String | Array(String) | Nil) = nil, topics : (Array(String | Array(String) | Nil)) = nil)
      filter = FilterObject.new(from_block, to_block, address, topics)
      @rpc.request ParamsRequest(FilterObject).new("eth_newFilter", [filter]), ResultResponse(Array(FilterChanges | String))
    end

    def get_work
      @rpc.request BaseRequest.new("eth_getWork"), ResultResponse(Array(String))
    end

    def submit_work(nonce : String, header_pow_hash : String, mix_digest : String)
      @rpc.request ParamsRequest(String).new("eth_submitWork", [nonce, header_pow_hash, mix_digest]), ResultResponse(Bool)
    end

    def submit_hashrate(hashrate : String, id : String)
      @rpc.request ParamsRequest(String).new("eth_submitHashrate", [hashrate, id]), ResultResponse(Bool)
    end
  end
end
