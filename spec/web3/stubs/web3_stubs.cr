require "../web3_spec_helper"

module Web3::Stubs
  web3_rpc_stub_no_params("web3_clientVersion", "Spec-Rpc/Crystal-0.26.1")

  web3_rpc_stub("web3_sha3", ["0x48656c6c6f21"], "0x6cdba77591a790691c694fa0be937f835b8a589095e427022aa1035e579ee596")
end
