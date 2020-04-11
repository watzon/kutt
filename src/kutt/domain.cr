require "json"

module Kutt
  record Domain,
      address : String,
      banned : Bool,
      id : String,
      homepage : String,
      created_at : String,
      updated_at : String do
    include JSON::Serializable
  end
end
