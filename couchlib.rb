module Couch
  class BadResponse < Exception
  end
  require 'net/http'
  require 'json'
  config_file = File.open "./config.json"
  config = JSON.load config
  config_file.close
  Host = "#{config["host"]}:5984"
  Login = config["login"]
  Password = config["password"]
  def self.add(db_name)
    uri = URI("http://#{Host}/#{db_name}")
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Put.new uri
      request.basic_auth Login, Password
      response = http.request request
      raise BadResponse, response.body if not JSON.parse(response.body)["ok"]
    end
  end
  def self.delete(db_naem)
    uri = URI("http://#{Host}/#{db_name}")
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Delete.new uri
      request.basic_auth Login, Password
      response = http.request request
      raise BadResponse, response.body if not JSON.parse(response.body)["ok"]
    end
  end
  def self.list
    uri = URI("http://#{Host}/_all_dbs")
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new uri 
      request.basic_auth Login, Password
      response = http.request request
      return eval(response.body)
    end
  end
  def self.uuid
    uri = URI("http://#{Host}/_uuids")
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new uri
      request.basic_auth Login, Password
      response = http.request request
      return JSON.parse(response.body)["uuids"][0]
    end
  end
end
