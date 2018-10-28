require "big"

module Web3::Helpers
  module Formatter
    struct ::Int
      def to_block_param : String
        String::ZERO_X + to_s(16).rjust_even
      end
    end

    struct ::BigInt
      def to_block_param : String
        String::ZERO_X + to_s(16).rjust_even
      end
    end

    class ::String
      ZERO_X = "0x"
      DEFAULT_BLOCK_STRINGS = %w(earliest latest pending)

      def to_block_param : self
        if DEFAULT_BLOCK_STRINGS.any? &.== self
          self
        elsif hex_param?
          to_hex_param
        else
          raise "Not block param!"
        end
      end

      def hex_param? : Bool
        return false unless zero_prefixed?
        chars = strip_zero.chars
        chars.all?(&.hex?) && chars.size >= 2 && chars.size.even?
      end

      def to_hex_param : self
        if zero_prefixed?
          zero_striped = strip_zero
          if zero_striped.chars.all? &.hex?
            return ZERO_X + zero_striped.rjust_even
          end
        end
        ZERO_X + to_slice.hexstring
      end

      def rjust_even(char : Char = '0') : self
        rjust(Math.max(size + size % 2, 2), char)
      end

      def zero_prefixed? : Bool
        starts_with? ZERO_X
      end

      def strip_zero : self
        zero_prefixed? ? self[2..-1] : self
      end
    end

    struct ::Slice(T)
      def to_hex_param : String
        String::ZERO_X + self.hexstring.rjust_even
      end
    end

    struct ::Symbol
      def to_block_param : String
        to_s.to_block_param
      end
    end
  end
end
