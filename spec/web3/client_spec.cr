require "result/result"

require "./web3_spec_helper"

require "../../src/web3"
require "../../src/web3/client"
require "../../src/web3/providers/rpc_provider"
require "./stubs/web3_stubs"

include Web3
include Web3::Providers
include Web3::Stubs

describe Web3::Client do
  WebMock.allow_net_connect = true
  web3 = Web3::Client.new(RpcProvider.new("spec_rpc"))

  Spec.before_each do
    RpcProvider.id = 1
  end

  describe "#client_version" do
    it "should returns client-version" do
      web3.client_version.should eq("Spec-Rpc/Crystal-0.26.1")
    end
  end

  describe "#sha3" do
    it "should return keccak-256 hash of 'Hello!'" do
      web3.sha3("Hello!").should eq("0x6cdba77591a790691c694fa0be937f835b8a589095e427022aa1035e579ee596")
    end

    it "should return keccak-256 hash of hex-encoded 'Hello!'" do
      web3.sha3("0x48656c6c6f21").should eq("0x6cdba77591a790691c694fa0be937f835b8a589095e427022aa1035e579ee596")
    end

    it "should return keccak-256 hash of byte-encoded 'Hello!'" do
      web3.sha3(Bytes[72_u8, 101_u8, 108_u8, 108_u8, 111_u8, 33_u8]).should eq("0x6cdba77591a790691c694fa0be937f835b8a589095e427022aa1035e579ee596")
    end
  end
end
