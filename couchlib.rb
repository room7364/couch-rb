module Couch
  require 'net/http'
  Host = '127.0.0.1:5984'
  Login = 'admin'
  Password = 'c'
  def self.create(db)
    uri = URI("http://#{Host}/#{db}")
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Put.new uri
      request.basic_auth Login, Password
      http.request request
    end
  end
  def self.delete(db)
    uri = URI("http://#{Host}/#{db}")
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Delete.new uri
      request.basic_auth Login, Password
      http.request request
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
end
