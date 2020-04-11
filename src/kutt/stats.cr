require "json"

module Kutt
  record StatEntry, name : String, value : Int32 do
    include JSON::Serializable
  end

  record Stats,
      browser : Array(StatEntry),
      os : Array(StatEntry),
      country : Array(StatEntry),
      referrer : Array(StatEntry) do
    include JSON::Serializable
  end

  record TimeFrame, stats : Stats, views : Array(Int32) do
    include JSON::Serializable
  end

  record LinkStats,
      all_time : TimeFrame,
      last_day : TimeFrame,
      last_month : TimeFrame,
      last_week : TimeFrame,
      created_at : String,
      updated_at : String,
      id : String,
      link : String,
      password : Bool,
      target : String,
      visit_count : Int32 do
    include JSON::Serializable

    @[JSON::Field(key: "allTime")]
    getter all_time : TimeFrame

    @[JSON::Field(key: "lastDay")]
    getter last_day : TimeFrame

    @[JSON::Field(key: "lastWeek")]
    getter last_week : TimeFrame

    @[JSON::Field(key: "lastMonth")]
    getter last_month : TimeFrame
  end
end
