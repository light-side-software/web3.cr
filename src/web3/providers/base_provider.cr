require "../models/base_request"

module Web3::Providers
  abstract class BaseProvider
    abstract def request(request : BaseRequest, result_type : ResultT.class) forall ResultT
  end
end
