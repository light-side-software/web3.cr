require "json"

module Web3::Models
  class Error
    JSON.mapping({
      code: {type: Int32},
      message: {type: String},
    })

    def initialize(@code : Int32, @message : String)
    end
  end
end
