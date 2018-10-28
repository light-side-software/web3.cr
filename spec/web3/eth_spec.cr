require "./web3_spec_helper"

require "../../src/web3"
require "../../src/web3/client"
require "../../src/web3/providers/rpc_provider"
require "./stubs/eth_stubs"

include Web3
include Web3::Stubs

describe Web3::Eth do
  WebMock.allow_net_connect = true
  web3 = Web3::Client.new(Web3::Providers::RpcProvider.new("spec_rpc"))

  Spec.before_each do
    RpcProvider.id = 1
  end

  describe "#protocol_version" do
    it "should returns protocol-version" do
      web3.eth.protocol_version.should eq("63")
    end
  end

  describe "#syncing" do
    it "is false when no syncing" do
      web3.eth.syncing.should be_false
    end

    it "should returns syncing-information while syncing" do
      RpcProvider.id = 2
      syncing = web3.eth.syncing
      syncing.should be_a(SyncingResult)
      syncing_result = syncing.as(SyncingResult)
      syncing_result.starting_block.should eq(900.to_big_i)
      syncing_result.current_block.should eq(902.to_big_i)
      syncing_result.highest_block.should eq(1108.to_big_i)
      syncing_result.known_states.should be_nil
      syncing_result.pulled_states.should be_nil
    end
  end

  describe "#coinbase" do
    it "is a valid address" do
      web3.eth.coinbase.should eq("0x00a329c0648769a73afac7f9381e08fb43dbea72")
    end
  end

  describe "#mining" do
    it "is false" do
      web3.eth.mining.should be_false
    end
  end

  describe "#hashrate" do
    it "should returns big-integer" do
      web3.eth.hashrate.should eq(906.to_big_i)
    end
  end

  describe "#gas_price" do
    it "should returns big-integer" do
      web3.eth.gas_price.should eq(10000000000000.to_big_i)
    end
  end

  describe "#accounts" do
    it "should returns addresses" do
      web3.eth.accounts.should eq(["0x00a329c0648769a73afac7f9381e08fb43dbea72", "0xd947716a7d2a54cF92102ac60de90206f6a3a19f"])
    end
  end

  describe "#block_number" do
    it "should returns number of blocks" do
      web3.eth.block_number.should eq(2.to_big_i)
    end
  end

  describe "#get_balance" do
    it "should returns big-integer" do
      web3.eth.get_balance("0x00a329c0648769a73afac7f9381e08fb43dbea72", "latest").should eq(158972490234375000.to_big_i)
    end
  end

  describe "#get_storage_at" do
    it "should returns hex-encoded data" do
      web3.eth.get_storage_at("0x295a70b2de5e3953354a6a8344e616ed314d7251", 0, :latest).should eq("0x00000000000000000000000000000000000000000000000000000000000004d2")
    end
  end

  describe "#get_transaction_count" do
    it "should returns big-integer" do
      web3.eth.get_transaction_count("0xc94770007dda54cF92009BFF0dE90c06F603a09f", :latest).should eq(1.to_big_i)
    end
  end

  describe "#get_block_transaction_count_by_hash" do
    it "should returns big-integer" do
      web3.eth.get_block_transaction_count_by_hash("0xfb3a8c858ac3ee23e416c3207d96df731cd35e07e02f6f3a4a0514603d056c53").should eq(1.to_big_i)
    end
  end

  describe "#get_block_transaction_count_by_number" do
    it "should work with integer-number & returns big-integer" do
      web3.eth.get_block_transaction_count_by_number(1).should eq(1.to_big_i)
    end

    it "should work with big-integer-number & returns big-integer" do
      web3.eth.get_block_transaction_count_by_number(1.to_big_i).should eq(1.to_big_i)
    end
  end

  describe "#get_uncle_count_by_block_hash" do
    it "should returns big-integer" do
      web3.eth.get_uncle_count_by_block_hash("0xfb3a8c858ac3ee23e416c3207d96df731cd35e07e02f6f3a4a0514603d056c53").should eq(1.to_big_i)
    end
  end

  describe "#get_uncle_count_by_block_number" do
    it "should work with integer-number & returns big-integer" do
      web3.eth.get_uncle_count_by_block_number(1).should eq(1.to_big_i)
    end

    it "should work with big-integer-number & returns big-integer" do
      web3.eth.get_uncle_count_by_block_number(1.to_big_i).should eq(1.to_big_i)
    end
  end

  describe "#get_code" do
    it "should returns hex-encoded data" do
      web3.eth.get_code("0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b").should eq("0x60601234567890")
    end
  end

  describe "#sign" do
    it "should returns hex-encoded data" do
      web3.eth.sign("0x9b2055d370f73ec7d8a03e965129118dc8f5bf83", "0xdeadbeaf").should eq("0xa3f20717a250c2b0b729b7e5becbff67fdaef7e0699da4de7ca5895b02a170a12d887fd3b17bfdce3481f10bea41f45ba9f709d39ce8325427b57afcfc994cee1b")
    end
  end

  describe "#send_transaction" do
    it "should return tx-hash" do
      web3.eth.send_transaction(
        from: "0x00a329c0648769a73afac7f9381e08fb43dbea72",
        to: "0xd46e8dd67c5d32be8058bb8eb970870f07244567",
        gas: 30400.to_big_i,
        gas_price: 10000000000000.to_big_i,
        value: 2441406250.to_big_i,
        data: "0x82456935")
      .should eq("0x5aacf7a8875b727d7caf587a68fbebecf358760a5a7c1e958c6beb61696fd903")
    end
  end

  describe "#call" do
    it "should return empty-data" do
      web3.eth.call(
        from: "0x00a329c0648769a73afac7f9381e08fb43dbea72",
        to: "0xd46e8dd67c5d32be8058bb8eb970870f07244567",
        gas: 30400.to_big_i,
        gas_price: 10000000000000.to_big_i,
        value: 2441406250.to_big_i,
        data: "0x82456935")
      .should eq("0x")
    end
  end

  describe "#estimate_gas" do
    it "should return gas-amount" do
      web3.eth.estimate_gas(
        from: "0x00a329c0648769a73afac7f9381e08fb43dbea72",
        to: "0xd46e8dd67c5d32be8058bb8eb970870f07244567",
        gas: 30400.to_big_i,
        gas_price: 10000000000000.to_big_i,
        value: 2441406250.to_big_i,
        data: "0x82456935")
      .should eq(21000.to_big_i)
    end
  end

  describe "#get_block_by_hash" do
    it "should retunrns first block" do
      block = web3.eth.get_block_by_hash "0xfb3a8c858ac3ee23e416c3207d96df731cd35e07e02f6f3a4a0514603d056c53", false
      block.should be_a(Block)
      block.author.should eq("0x9267452378328762458765863555363566363266")
      block.difficulty.should eq(131072.to_big_i)
      block.extra_data.should eq("0xde830200068f5061726974792d457468657265756d86312e32392e30826c69")
      block.gas_limit.should eq(8000000.to_big_i)
      block.gas_used.should eq(21000.to_big_i)
      block.hash.should eq("0xfb3a8c858ac3ee23e416c3207d96df731cd35e07e02f6f3a4a0514603d056c53")
      block.logs_bloom.should eq("0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
      block.miner.should eq("0x9267452378328762458765863555363566363266")
      block.number.should eq(1.to_big_i)
      block.parent_hash.should eq("0x586817cd17aa2108693836adcacb3b5376b981361484bce8c021f2ca46a480b6")
      block.receipts_root.should eq("0x056b23fbba480696b65fe5a59b8f2148a1299103c4f57df839233af2cf4ca2d2")
      block.seal_fields.should be_a(Array(String))
      block.sha3_uncles.should eq("0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347")
      block.size.should eq(613.to_big_i)
      block.state_root.should eq("0x5681fe28b6ed22a4091761ba55cd47035f5911b03277e57b55979dee8c3cdad5")
      block.timestamp.should eq("0x5ba7835b")
      block.total_difficulty.should eq(262144.to_big_i)
      block.transactions.should eq(["0x5aacf7a8875b727d7caf587a68fbebecf358760a5a7c1e958c6beb61696fd903"])
      block.transactions_root.should eq("0x423ad13a1dfc9ee39df6469b1cf828b46dd313a667cbdb934645c23e0dcd3416")
      block.uncles.should eq(["0x1598745f23a2498180464984f5245429783a7968f7525208613527368a749678"])
    end
  end

  describe "#get_block_by_number" do
    it "should returns first block" do
      block = web3.eth.get_block_by_number 1, false
      block.should be_a(Block)
      block.author.should eq("0x9267452378328762458765863555363566363266")
      block.difficulty.should eq(131072.to_big_i)
      block.extra_data.should eq("0xde830200068f5061726974792d457468657265756d86312e32392e30826c69")
      block.gas_limit.should eq(8000000.to_big_i)
      block.gas_used.should eq(21000.to_big_i)
      block.hash.should eq("0xfb3a8c858ac3ee23e416c3207d96df731cd35e07e02f6f3a4a0514603d056c53")
      block.logs_bloom.should eq("0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
      block.miner.should eq("0x9267452378328762458765863555363566363266")
      block.number.should eq(1.to_big_i)
      block.parent_hash.should eq("0x586817cd17aa2108693836adcacb3b5376b981361484bce8c021f2ca46a480b6")
      block.receipts_root.should eq("0x056b23fbba480696b65fe5a59b8f2148a1299103c4f57df839233af2cf4ca2d2")
      block.seal_fields.should be_a(Array(String))
      block.sha3_uncles.should eq("0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347")
      block.size.should eq(613.to_big_i)
      block.state_root.should eq("0x5681fe28b6ed22a4091761ba55cd47035f5911b03277e57b55979dee8c3cdad5")
      block.timestamp.should eq("0x5ba7835b")
      block.total_difficulty.should eq(262144.to_big_i)
      block.transactions.should eq(["0x5aacf7a8875b727d7caf587a68fbebecf358760a5a7c1e958c6beb61696fd903"])
      block.transactions_root.should eq("0x423ad13a1dfc9ee39df6469b1cf828b46dd313a667cbdb934645c23e0dcd3416")
      block.uncles.should eq(["0x1598745f23a2498180464984f5245429783a7968f7525208613527368a749678"])
    end
  end

  describe "#get_transaction_by_hash" do
    it "should return first transaction" do
      transaction = web3.eth.get_transaction_by_hash "0x88df016429689c079f3b2f6ad39fa052532c56795b733da78a91ebe6a713944b"
      transaction.block_hash.should eq("0x1d59ff54b1eb26b013ce3cb5fc9dab3705b415a67127a003c3e61eb445bb8df2")
      transaction.block_number.should eq(1.to_big_i)
      transaction.from.should eq("0xa7d9ddbe1f17865597fbd27ec712455208b6b76d")
      transaction.gas.should eq(50000.to_big_i)
      transaction.gas_price.should eq(305175.to_big_i)
      transaction.hash.should eq("0x88df016429689c079f3b2f6ad39fa052532c56795b733da78a91ebe6a713944b")
      transaction.input.should eq("0x68656c6c6f21")
      transaction.nonce.should eq(21.to_big_i)
      transaction.r.should eq("0x1b5e176d927f8e9ab405058b2d2457392da3e20f328b16ddabcebc33eaac5fea")
      transaction.s.should eq("0x4ba69724e8f69de52f0125ad8b3c5c2cef33019bac3249e2c0a2192766d1721c")
      transaction.to.should eq("0xf02c1c8e6114b1dbe8937a39260b5b0a374432bb")
      transaction.transaction_index.should eq(0.to_big_i)
      transaction.v.should eq(37.to_big_i)
      transaction.value.should eq(4290000000000000.to_big_i)
    end
  end

  describe "#get_transaction_by_block_hash_and_index" do
    it "should return first transaction" do
      transaction = web3.eth.get_transaction_by_block_hash_and_index "0x1d59ff54b1eb26b013ce3cb5fc9dab3705b415a67127a003c3e61eb445bb8df2", 0
      transaction.block_hash.should eq("0x1d59ff54b1eb26b013ce3cb5fc9dab3705b415a67127a003c3e61eb445bb8df2")
      transaction.block_number.should eq(1.to_big_i)
      transaction.from.should eq("0xa7d9ddbe1f17865597fbd27ec712455208b6b76d")
      transaction.gas.should eq(50000.to_big_i)
      transaction.gas_price.should eq(305175.to_big_i)
      transaction.hash.should eq("0x88df016429689c079f3b2f6ad39fa052532c56795b733da78a91ebe6a713944b")
      transaction.input.should eq("0x68656c6c6f21")
      transaction.nonce.should eq(21.to_big_i)
      transaction.r.should eq("0x1b5e176d927f8e9ab405058b2d2457392da3e20f328b16ddabcebc33eaac5fea")
      transaction.s.should eq("0x4ba69724e8f69de52f0125ad8b3c5c2cef33019bac3249e2c0a2192766d1721c")
      transaction.to.should eq("0xf02c1c8e6114b1dbe8937a39260b5b0a374432bb")
      transaction.transaction_index.should eq(0.to_big_i)
      transaction.v.should eq(37.to_big_i)
      transaction.value.should eq(4290000000000000.to_big_i)
    end
  end

  describe "#get_transaction_by_block_number_and_index" do
    it "should return first transaction" do
      transaction = web3.eth.get_transaction_by_block_number_and_index 1, 0
      transaction.block_hash.should eq("0x1d59ff54b1eb26b013ce3cb5fc9dab3705b415a67127a003c3e61eb445bb8df2")
      transaction.block_number.should eq(1.to_big_i)
      transaction.from.should eq("0xa7d9ddbe1f17865597fbd27ec712455208b6b76d")
      transaction.gas.should eq(50000.to_big_i)
      transaction.gas_price.should eq(305175.to_big_i)
      transaction.hash.should eq("0x88df016429689c079f3b2f6ad39fa052532c56795b733da78a91ebe6a713944b")
      transaction.input.should eq("0x68656c6c6f21")
      transaction.nonce.should eq(21.to_big_i)
      transaction.r.should eq("0x1b5e176d927f8e9ab405058b2d2457392da3e20f328b16ddabcebc33eaac5fea")
      transaction.s.should eq("0x4ba69724e8f69de52f0125ad8b3c5c2cef33019bac3249e2c0a2192766d1721c")
      transaction.to.should eq("0xf02c1c8e6114b1dbe8937a39260b5b0a374432bb")
      transaction.transaction_index.should eq(0.to_big_i)
      transaction.v.should eq(37.to_big_i)
      transaction.value.should eq(4290000000000000.to_big_i)
    end
  end

  describe "#get_transaction_receipt" do
    it "should return receipt of first transaction" do
      receipt = web3.eth.get_transaction_receipt "0x5aacf7a8875b727d7caf587a68fbebecf358760a5a7c1e958c6beb61696fd903"
      receipt.block_hash.should eq("0x1d59ff54b1eb26b013ce3cb5fc9dab3705b415a67127a003c3e61eb445bb8df2")
      receipt.block_number.should eq(1.to_big_i)
      receipt.contract_address.should be_nil
      receipt.cumulative_gas_used.should eq(21000.to_big_i)
      receipt.from.should eq("0x00a329c0648769a73afac7f9381e08fb43dbea72")
      receipt.gas_used.should eq(21000.to_big_i)
      receipt.logs.empty?.should be_true
      receipt.logs_bloom.should eq("0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
      receipt.root.should be_nil
      receipt.status.should eq(1.to_big_i)
      receipt.to.should eq("0x43663493dba8b9ef800483bd4af9cf11b74eb42e")
      receipt.transaction_hash.should eq("0x5aacf7a8875b727d7caf587a68fbebecf358760a5a7c1e958c6beb61696fd903")
      receipt.transaction_index.should eq(0.to_big_i)
    end
  end

  describe "#get_uncle_by_block_hash_and_index" do
    it "should return uncle of second block" do
      uncle = web3.eth.get_uncle_by_block_hash_and_index "0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b", 0
      uncle.difficulty.should eq(163591.to_big_i)
      uncle.extra_data.should eq("0x0000000000000000000000000000000000000000000000000000000000000000")
      uncle.gas_limit.should eq(653145.to_big_i)
      uncle.gas_used.should eq(653145.to_big_i)
      uncle.hash.should eq("0xa73459c64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331")
      uncle.logs_bloom.should eq("0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331")
      uncle.miner.should eq("0x4e65fda2159562a496f9f3522f89122a3088497a")
      uncle.number.should eq(2.to_big_i)
      uncle.nonce.should eq("0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2")
      uncle.parent_hash.should eq("0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5")
      uncle.receipts_root.should eq("0x056b23fbba480696b65fe5a59b8f2148a1299103c4f57df839233af2cf4ca2d2")
      uncle.sha3_uncles.should eq("0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347")
      uncle.size.should eq(163591.to_big_i)
      uncle.state_root.should eq("0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff")
      uncle.timestamp.should eq("0x54e34e8e")
      uncle.total_difficulty.should eq(163591.to_big_i)
      uncle.transactions.empty?.should be_true
      uncle.transactions_root.should eq("0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421",)
      uncle.uncles.empty?.should be_true
    end
  end

  describe "#get_uncle_by_block_number_and_index" do
    it "should return uncle of second block" do
      uncle = web3.eth.get_uncle_by_block_number_and_index 2, 0
      uncle.difficulty.should eq(163591.to_big_i)
      uncle.extra_data.should eq("0x0000000000000000000000000000000000000000000000000000000000000000")
      uncle.gas_limit.should eq(653145.to_big_i)
      uncle.gas_used.should eq(653145.to_big_i)
      uncle.hash.should eq("0xa73459c64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331")
      uncle.logs_bloom.should eq("0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331")
      uncle.miner.should eq("0x4e65fda2159562a496f9f3522f89122a3088497a")
      uncle.number.should eq(2.to_big_i)
      uncle.nonce.should eq("0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2")
      uncle.parent_hash.should eq("0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5")
      uncle.receipts_root.should eq("0x056b23fbba480696b65fe5a59b8f2148a1299103c4f57df839233af2cf4ca2d2")
      uncle.sha3_uncles.should eq("0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347")
      uncle.size.should eq(163591.to_big_i)
      uncle.state_root.should eq("0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff")
      uncle.timestamp.should eq("0x54e34e8e")
      uncle.total_difficulty.should eq(163591.to_big_i)
      uncle.transactions.empty?.should be_true
      uncle.transactions_root.should eq("0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421",)
      uncle.uncles.empty?.should be_true
    end
  end

  describe "#new_filter" do
    it "should returns new filters's id" do
      web3.eth.new_filter(
        from_block: 1.to_big_i,
        to_block: 2.to_big_i,
        address: "0x8888f1f195afa192cfee860698584c030f4c9db1",
        topics: [
          "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b",
          nil, [
            "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b",
            "0x000000000000000000000000aff3454fce5edbc8cca8697c15331677e6ebccc"
          ]
        ]
      ).should eq(1.to_big_i)
    end
  end

  describe "#new_block_filter" do
    it "should returns new filters's id" do
      web3.eth.new_block_filter.should eq(1.to_big_i)
    end
  end

  describe "#new_pending_transaction_filter" do
    it "should returns new filters's id" do
      web3.eth.new_pending_transaction_filter.should eq(1.to_big_i)
    end
  end

  describe "#uninstall_filter" do
    it "should returns true" do
      web3.eth.uninstall_filter(11.to_big_i).should be_true
    end
  end

  describe "#get_filter_changes" do
    it "should returns object" do
      result = web3.eth.get_filter_changes(16)
      result.size.should eq(1)
      result.first.should be_a(FilterChanges)
      filter_changes = result.first.as(FilterChanges)
      filter_changes.log_index.should eq(1.to_big_i)
      filter_changes.block_number.should eq(436.to_big_i)
      filter_changes.block_hash.should eq("0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d")
      filter_changes.transaction_hash.should eq("0xdf829c5a142f1fccd7d8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcf")
      filter_changes.transaction_index.should eq(0.to_big_i)
      filter_changes.address.should eq("0x16c5785ac562ff41e2dcfdf829c5a142f1fccd7d")
      filter_changes.data.should eq("0x0000000000000000000000000000000000000000000000000000000000000000")
      filter_changes.topics.should eq(["0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5"])
    end
  end

  describe "#get_filter_logs" do
    it "should returns object" do
      result = web3.eth.get_filter_logs(16)
      result.size.should eq(1)
      result.first.should be_a(FilterChanges)
      filter_changes = result.first.as(FilterChanges)
      filter_changes.log_index.should eq(1.to_big_i)
      filter_changes.block_number.should eq(436.to_big_i)
      filter_changes.block_hash.should eq("0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d")
      filter_changes.transaction_hash.should eq("0xdf829c5a142f1fccd7d8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcf")
      filter_changes.transaction_index.should eq(0.to_big_i)
      filter_changes.address.should eq("0x16c5785ac562ff41e2dcfdf829c5a142f1fccd7d")
      filter_changes.data.should eq("0x0000000000000000000000000000000000000000000000000000000000000000")
      filter_changes.topics.should eq(["0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5"])
    end
  end

  describe "#get_logs" do
    it "should returns object" do
    end
  end

  describe "#get_work" do
    it "" do
    end
  end

  describe "#submit_work" do
    it "should returns true" do
      web3.eth.submit_work(
        nonce: "0x0000000000000001",
        header_pow_hash: "0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef",
        mix_digest: "0xd1fe5700000000000000000000000000d1fe5700000000000000000000000000"
      ).should be_true
    end
  end

  describe "#submit_hashrate" do
    it "should returns true" do
      web3.eth.submit_hashrate(
        hashrate: "0x0000000000000000000000000000000000000000000000000000000000500000",
        id: "0x59daa26581d0acd1fce254fb7e85952f4c09d0915afd33d3886cd914bc7d283c"
      ).should be_true
    end
  end
end
