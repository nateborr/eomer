require './eomer'

configure do
  require 'redis'
  uri = URI.parse(ENV['REDISCLOUD_URL'] || 'redis://localhost:6379/3')

  params = { :host => uri.host, :port => uri.port, :password => uri.password }
  uri_path_match = %r{/(\d+)}.match(uri.path)
  if !uri_path_match.nil?
    params[:db] = uri_path_match[1].to_i
  end

  Redis.current = Redis.new(params)
end

run Sinatra::Application