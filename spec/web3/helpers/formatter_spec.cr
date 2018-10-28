require "big"

require "../../spec_helper"
require "../../../src/web3/helpers/formatter"

describe Web3::Helpers do
  describe Int do
    describe "#to_block_param" do
      it "should converts integer values to block-param" do
        1_u8.to_block_param.should eq("0x01")
        255_u8.to_block_param.should eq("0xff")
        1.to_block_param.should eq("0x01")
        16.to_block_param.should eq("0x10")
      end
    end
  end

  describe BigInt do
    describe "#to_block_param" do
      it "converts value to block-param" do
        1.to_big_i.to_block_param.should eq("0x01")
        2730992.to_big_i.to_block_param.should eq("0x29abf0")
        730992.to_big_i.to_block_param.should eq("0x0b2770")
      end
    end
  end

  describe String do
    describe "#to_block_param" do
      it "should be allowed" do
        "earliest".to_block_param.should eq("earliest")
        "latest".to_block_param.should eq("latest")
        "pending".to_block_param.should eq("pending")
      end

      it "is not block-param" do
        expect_raises(Exception, "Not block param!") do
          "last".to_block_param
        end
      end
    end

    describe "#hex_param?" do
      it "correctly recognizes hex-params" do
        "0x00".hex_param?.should be_true
        "0x01".hex_param?.should be_true
        "0xacbd01".hex_param?.should be_true
        "0x01acbd".hex_param?.should be_true

        "0x".hex_param?.should be_false
        "0x0".hex_param?.should be_false
        "0x1".hex_param?.should be_false
        "0xab7".hex_param?.should be_false
      end
    end

    describe "#to_hex_param" do
      it "correctly converts strings to hex-params" do
        "0x".to_hex_param.should eq("0x00")
        "0x0".to_hex_param.should eq("0x00")
        "0x00".to_hex_param.should eq("0x00")
        "0x1".to_hex_param.should eq("0x01")
        "0x01".to_hex_param.should eq("0x01")

        "Hello!".to_hex_param.should eq("0x48656c6c6f21")
      end
    end

    describe "#rjust_even" do
      it "should completes strings to even-length" do
        "".rjust_even('1').should eq("11")
        "0".rjust_even.should eq("00")
        "ab".rjust_even.should eq("ab")
        "abc".rjust_even.should eq("0abc")
      end
    end

    describe "#zero_prefixed?" do
      it "is true" do
        "0x1234".zero_prefixed?.should be_true
      end

      it "is false" do
        "1234".zero_prefixed?.should be_false
      end
    end

    describe "#strip_zero" do
      it "should does nothing" do
        "1234".strip_zero.should eq("1234")
        "0123".strip_zero.should eq("0123")
        "x012".strip_zero.should eq("x012")
      end

      it "should deletes '0x' from beggining" do
        "0x1234".strip_zero.should eq("1234")
      end
    end
  end

  describe Symbol do
    describe "#to_block_param" do
      it "should be allowed" do
        :earliest.to_block_param.should eq("earliest")
        :latest.to_block_param.should eq("latest")
        :pending.to_block_param.should eq("pending")
      end

      it "is not block-param" do
        expect_raises(Exception, "Not block param!") do
          :last.to_block_param
        end
      end
    end
  end

  describe Bytes do
    describe "#to_hex_param" do
      it "correctly converts bytes to hex-params" do
        Bytes[0x00, 0x11].to_hex_param.should eq("0x0011")
        Bytes[16, 255].to_hex_param.should eq("0x10ff")
      end
    end
  end
end
