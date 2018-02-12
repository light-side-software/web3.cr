require "big"
require "json"

module BigInt::HexStringConverter
  def self.from_json(parser : JSON::PullParser) : BigInt?
    s = parser.read_string
    if s.is_a? String
      s.starts_with?("0x") ? s[2..-1].to_big_i(16) : s.to_big_i(10)
    else
      nil
    end
  end

  def self.to_json(value : BigInt, builder : JSON::Builder)
    builder.string("0x" + value.to_s(16))
  end
end
