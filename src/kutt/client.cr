require "halite"

module Kutt
  class Client
    def initialize(api_key : String, version : Int = 2)
      @client = Halite::Client.new(
        endpoint: "https://kutt.it/api/v#{version}/",
        headers: {"X-API_KEY" => api_key}
      )
    end

    def health
      response = request("GET", "health")
      response.status_code == 200
    end

    def info
      response = request("GET", "users")
      UserInfo.from_json(response.body)
    end

    def links(limit = 10, skip = 0, all = false)
      limit = 0 if all
      params = {limit: limit, skip: skip, all: all}
      response = request("GET", "links", params: params)
      Links.from_json(response.body)
    end

    def shorten(url : String,
                password : String? = nil,
                custom_url : String? = nil,
                reuse : Bool = false,
                domain : String? = nil)
      payload = { target: url, reuse: reuse }
      {% for item in %w(password custom_url domain) %}
        payload.merge({ {{item.id}}: {{item.id}} }) if {{item.id}}
      {% end %}
      response = request("POST", "links", payload: payload)
      Link.from_json(response.body)
    end

    def delete_link(id)
      response = request("DELETE", "links/#{id}")
      response.status_code == 200
    end

    def link_stats(id)
      response = request("GET", "links/#{id}/stats")
      LinkStats.from_json(response.body)
    end

    def add_domain(address : String, homepage : String)
      params = { address: address, homepage: homepage }
      response = request("POST", "domains", params)
      Domain.from_json(response.body)
    end

    def delete_domain(id)
      response = request("DELETE", "domains/#{id}")
      response.status_code == 200
    end

    private def request(verb, path, params = nil, payload = nil)
      options = payload ? Halite::Options.new(params: params, json: payload) : nil
      @client.request(verb, path, options)
    end
  end
end
