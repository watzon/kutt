require "json"

module Kutt
  record UserInfo,
      apikey : String,
      email : String,
      domains : Array(Domain) do
    include JSON::Serializable
  end
end
