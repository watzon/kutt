require "json"

module Kutt
  record Link,
      address : String,
      banned : Bool,
      id : String,
      link : String,
      password : Bool,
      target : String,
      visit_count : Int32,
      created_at : String,
      updated_at : String do
    include JSON::Serializable
  end

  record Links,
      limit : Int32,
      skip : Int32,
      total : Int32,
      data : Array(Link) do
    include JSON::Serializable
  end
end
