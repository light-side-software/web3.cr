require "big"

module Web3::Helpers
  module Formatter
    DEFAULT_BLOCKS = ["earliest", "latest", "pending"]

    def self.block_string(block : (BigInt | String) = "latest") : String
      case block
        when BigInt then "0x" + block.as(BigInt).to_s(16)
        when DEFAULT_BLOCKS[0], DEFAULT_BLOCKS[1], DEFAULT_BLOCKS[2] then block.as(String)
        else raise ArgumentError.new("'block' must be a valid block number or one of #{DEFAULT_BLOCKS}")
      end
    end
  end
end


class String
  def zero_prefixed? : Bool
    self.starts_with? "0x"
  end

  def strip_zero : String
    if self.zero_prefixed?
      self[2..-1]
    else
      self
    end
  end
end
