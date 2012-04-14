#!/usr/bin/env ruby
require 'webrick'

server = WEBrick::HTTPServer.new(
	:BindAddress => "localhost",
	:Port => 8080,
	:DocumentRoot => Dir.pwd)

trap "INT" do
  server.shutdown
end

server.start