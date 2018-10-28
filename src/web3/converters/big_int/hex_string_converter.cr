require "big"
require "json"

module BigInt::HexStringConverter
  def self.from_json(parser : JSON::PullParser) : BigInt?
    (s = parser.read_string)
      .is_a?(String) ? (s.zero_prefixed? ? s.strip_zero.to_big_i(16) : s.to_big_i(10)) : nil
  end

  def self.to_json(value : ::BigInt, builder : JSON::Builder)
    builder.string(value.to_block_param)
  end
end
