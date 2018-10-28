require "../web3_spec_helper"

module Web3::Stubs
  web3_rpc_stub_no_params("eth_protocolVersion", "63")

  web3_rpc_stub_no_params("eth_syncing", false)

  web3_rpc_stub_no_params("eth_syncing", {
    "startingBlock": "0x384",
    "currentBlock": "0x386",
    "highestBlock": "0x454"
  }, 2)

  web3_rpc_stub_no_params("eth_coinbase", "0x00a329c0648769a73afac7f9381e08fb43dbea72")

  web3_rpc_stub_no_params("eth_mining", false)

  web3_rpc_stub_no_params("eth_hashrate", "0x38a")

  web3_rpc_stub_no_params("eth_gasPrice", "0x09184e72a000")

  web3_rpc_stub_no_params("eth_accounts", ["0x00a329c0648769a73afac7f9381e08fb43dbea72", "0xd947716a7d2a54cF92102ac60de90206f6a3a19f"])

  web3_rpc_stub_no_params("eth_blockNumber", "0x2")

  web3_rpc_stub("eth_getBalance", ["0x00a329c0648769a73afac7f9381e08fb43dbea72", "latest"], "0x0234c8a3397aab58")

  web3_rpc_stub("eth_getStorageAt", ["0x295a70b2de5e3953354a6a8344e616ed314d7251", "0x0", "latest"], "0x00000000000000000000000000000000000000000000000000000000000004d2")

  web3_rpc_stub("eth_getTransactionCount", ["0xc94770007dda54cF92009BFF0dE90c06F603a09f", "latest"], "0x1")

  web3_rpc_stub("eth_getBlockTransactionCountByHash", ["0xfb3a8c858ac3ee23e416c3207d96df731cd35e07e02f6f3a4a0514603d056c53"], "0x1")

  web3_rpc_stub("eth_getBlockTransactionCountByNumber", ["0x1"], "0x1")

  web3_rpc_stub("eth_getUncleCountByBlockHash", ["0xfb3a8c858ac3ee23e416c3207d96df731cd35e07e02f6f3a4a0514603d056c53"], "0x1")

  web3_rpc_stub("eth_getUncleCountByBlockNumber", ["0x1"], "0x1")

  web3_rpc_stub("eth_getCode", ["0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b", "latest"], "0x60601234567890")

  web3_rpc_stub("eth_sign", ["0x9b2055d370f73ec7d8a03e965129118dc8f5bf83", "0xdeadbeaf"], "0xa3f20717a250c2b0b729b7e5becbff67fdaef7e0699da4de7ca5895b02a170a12d887fd3b17bfdce3481f10bea41f45ba9f709d39ce8325427b57afcfc994cee1b")

  web3_rpc_stub("eth_sendTransaction", [{
    "data": "0x82456935",
    "from": "0x00a329c0648769a73afac7f9381e08fb43dbea72",
    "gas": "0x76c0",
    "gasPrice": "0x09184e72a000",
    "to": "0xd46e8dd67c5d32be8058bb8eb970870f07244567",
    "value": "0x9184e72a"
  }], "0x5aacf7a8875b727d7caf587a68fbebecf358760a5a7c1e958c6beb61696fd903")

  web3_rpc_stub("eth_sendRawTransaction", ["0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"], "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331")

  web3_rpc_stub("eth_call", [{
    "data": "0x82456935",
    "from": "0x00a329c0648769a73afac7f9381e08fb43dbea72",
    "gas": "0x76c0",
    "gasPrice": "0x09184e72a000",
    "to": "0xd46e8dd67c5d32be8058bb8eb970870f07244567",
    "value": "0x9184e72a"
  }, "latest"], "0x")

  web3_rpc_stub("eth_estimateGas", [{
    "data": "0x82456935",
    "from": "0x00a329c0648769a73afac7f9381e08fb43dbea72",
    "gas": "0x76c0",
    "gasPrice": "0x09184e72a000",
    "to": "0xd46e8dd67c5d32be8058bb8eb970870f07244567",
    "value": "0x9184e72a"
  }], "0x5208")

  BLOCK_1 = {
    "author": "0x9267452378328762458765863555363566363266",
    "difficulty": "0x20000",
    "extraData": "0xde830200068f5061726974792d457468657265756d86312e32392e30826c69",
    "gasLimit": "0x7a1200",
    "gasUsed": "0x5208",
    "hash": "0xfb3a8c858ac3ee23e416c3207d96df731cd35e07e02f6f3a4a0514603d056c53",
    "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    "miner": "0x9267452378328762458765863555363566363266",
    "number": "0x1",
    "parentHash": "0x586817cd17aa2108693836adcacb3b5376b981361484bce8c021f2ca46a480b6",
    "receiptsRoot": "0x056b23fbba480696b65fe5a59b8f2148a1299103c4f57df839233af2cf4ca2d2",
    "sealFields": [] of String,
    "sha3Uncles": "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347",
    "size": "0x265",
    "stateRoot": "0x5681fe28b6ed22a4091761ba55cd47035f5911b03277e57b55979dee8c3cdad5",
    "timestamp": "0x5ba7835b",
    "totalDifficulty": "0x40000",
    "transactions": [
      "0x5aacf7a8875b727d7caf587a68fbebecf358760a5a7c1e958c6beb61696fd903"
    ],
    "transactionsRoot": "0x423ad13a1dfc9ee39df6469b1cf828b46dd313a667cbdb934645c23e0dcd3416",
    "uncles": [
      "0x1598745f23a2498180464984f5245429783a7968f7525208613527368a749678"
    ]
  }

  web3_rpc_stub("eth_getBlockByHash", ["0xfb3a8c858ac3ee23e416c3207d96df731cd35e07e02f6f3a4a0514603d056c53", false], BLOCK_1)

  web3_rpc_stub("eth_getBlockByNumber", ["0x01", false], BLOCK_1)

  TRANSACTION_1_1 = {
    "blockHash": "0x1d59ff54b1eb26b013ce3cb5fc9dab3705b415a67127a003c3e61eb445bb8df2",
    "blockNumber": "0x1",
    "from": "0xa7d9ddbe1f17865597fbd27ec712455208b6b76d",
    "gas": "0xc350",
    "gasPrice": "0x4a817",
    "hash": "0x88df016429689c079f3b2f6ad39fa052532c56795b733da78a91ebe6a713944b",
    "input": "0x68656c6c6f21",
    "nonce": "0x15",
    "r": "0x1b5e176d927f8e9ab405058b2d2457392da3e20f328b16ddabcebc33eaac5fea",
    "s": "0x4ba69724e8f69de52f0125ad8b3c5c2cef33019bac3249e2c0a2192766d1721c",
    "to": "0xf02c1c8e6114b1dbe8937a39260b5b0a374432bb",
    "transactionIndex": "0x0",
    "v": "0x25",
    "value": "0xf3dbb76162000"
  }

  web3_rpc_stub("eth_getTransactionByHash", ["0x88df016429689c079f3b2f6ad39fa052532c56795b733da78a91ebe6a713944b"], TRANSACTION_1_1)

  web3_rpc_stub("eth_getTransactionByBlockHashAndIndex", ["0x1d59ff54b1eb26b013ce3cb5fc9dab3705b415a67127a003c3e61eb445bb8df2", "0x00"], TRANSACTION_1_1)

  web3_rpc_stub("eth_getTransactionByBlockNumberAndIndex", ["0x01", "0x00"], TRANSACTION_1_1)

  RECEIPT_1_1 = {
    "blockHash": "0x1d59ff54b1eb26b013ce3cb5fc9dab3705b415a67127a003c3e61eb445bb8df2",
    "blockNumber": "0x1",
    "contractAddress": nil,
    "cumulativeGasUsed": "0x5208",
    "from": "0x00a329c0648769a73afac7f9381e08fb43dbea72",
    "gasUsed": "0x5208",
    "logs": [] of String,
    "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    "root": nil,
    "status": "0x1",
    "to": "0x43663493dba8b9ef800483bd4af9cf11b74eb42e",
    "transactionHash": "0x5aacf7a8875b727d7caf587a68fbebecf358760a5a7c1e958c6beb61696fd903",
    "transactionIndex": "0x0"
  }

  web3_rpc_stub("eth_getTransactionReceipt", ["0x5aacf7a8875b727d7caf587a68fbebecf358760a5a7c1e958c6beb61696fd903"], RECEIPT_1_1)

  UNCLE_2_1 = {
    "difficulty": "0x027f07", # 163591
    "extraData": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "gasLimit": "0x9f759", # 653145
    "gasUsed": "0x9f759", # 653145
    "hash": "0xa73459c64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331",
    "logsBloom": "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331",
    "miner": "0x4e65fda2159562a496f9f3522f89122a3088497a",
    "number": "0x2",
    "nonce": "0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2",
    "parentHash": "0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5",
    "receiptsRoot": "0x056b23fbba480696b65fe5a59b8f2148a1299103c4f57df839233af2cf4ca2d2",
    "sha3Uncles": "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347",
    "size":  "0x027f07", # 163591
    "stateRoot": "0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff",
    "timestamp": "0x54e34e8e", # 1424182926
    "totalDifficulty":  "0x027f07", # 163591
    "transactions": [] of String,
    "transactionsRoot": "0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421",
    "uncles": [] of String
  }

  web3_rpc_stub("eth_getUncleByBlockHashAndIndex", ["0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b", "0x00"], UNCLE_2_1)

  web3_rpc_stub("eth_getUncleByBlockNumberAndIndex", ["0x02", "0x00"], UNCLE_2_1)

  FILTER_1 = {
    "address": "0x8888f1f195afa192cfee860698584c030f4c9db1",
    "fromBlock": "0x01",
    "topics": [
      "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b",
      nil,
      [
        "0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b",
        "0x000000000000000000000000aff3454fce5edbc8cca8697c15331677e6ebccc"
      ]
    ],
    "toBlock": "0x02"
  }

  web3_rpc_stub("eth_newFilter", [FILTER_1], "0x01")

  web3_rpc_stub_no_params("eth_newBlockFilter", "0x01")

  web3_rpc_stub_no_params("eth_newPendingTransactionFilter", "0x01")

  web3_rpc_stub("eth_uninstallFilter", ["0x0b"], true)

  FILTER_CHANGES_1 = [{
    "address": "0x16c5785ac562ff41e2dcfdf829c5a142f1fccd7d",
    "data": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "blockHash": "0x8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcfdf829c5a142f1fccd7d",
    "blockNumber": "0x01b4",
    "logIndex": "0x01",
    "topics": ["0x59ebeb90bc63057b6515673c3ecf9438e5058bca0f92585014eced636878c9a5"],
    "transactionHash":  "0xdf829c5a142f1fccd7d8216c5785ac562ff41e2dcfdf5785ac562ff41e2dcf",
    "transactionIndex": "0x00"
  }]

  web3_rpc_stub("eth_getFilterChanges", ["0x10"], FILTER_CHANGES_1)

  web3_rpc_stub("eth_getFilterLogs", ["0x10"], FILTER_CHANGES_1)

  web3_rpc_stub("eth_getLogs", [{"topics": ["0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b"]}], FILTER_CHANGES_1)

  web3_rpc_stub_no_params("eth_getWork", [
    "0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef",
    "0x5EED00000000000000000000000000005EED0000000000000000000000000000",
    "0xd1ff1c01710000000000000000000000d1ff1c01710000000000000000000000"
  ])

  web3_rpc_stub("eth_submitWork", [
    "0x0000000000000001",
    "0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef",
    "0xd1fe5700000000000000000000000000d1fe5700000000000000000000000000"
  ], true)

  web3_rpc_stub("eth_submitHashrate", [
    "0x0000000000000000000000000000000000000000000000000000000000500000",
    "0x59daa26581d0acd1fce254fb7e85952f4c09d0915afd33d3886cd914bc7d283c"
  ], true)
end
