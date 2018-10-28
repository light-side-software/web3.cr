require "spec"
require "webmock"

require "../../src/web3.cr"

module Web3
  def web3_rpc_stub_no_params(method, result, id = 1)
    WebMock.stub(:post, "spec_rpc")
      .with(body: {jsonrpc: "2.0", id: id, method: method}.to_json, headers: {"Content-Type" => "application/json"})
      .to_return(status: 200, body: {jsonrpc: "2.0", id: id, result: result}.to_json)
  end

  def web3_rpc_stub(method, params, result, id = 1)
    # if method == "eth_getFilterChanges"
    #   puts "stub-request"
    #   puts ({jsonrpc: "2.0", id: id, method: method, params: params}).to_json
    #   puts "stub-response"
    #   puts ({jsonrpc: "2.0", id: id, result: result}).to_json
    # end
    WebMock.stub(:post, "spec_rpc")
      .with(body: {jsonrpc: "2.0", id: id, method: method, params: params}.to_json, headers: {"Content-Type" => "application/json"})
      .to_return(status: 200, body: {jsonrpc: "2.0", id: id, result: result}.to_json)
  end
end
