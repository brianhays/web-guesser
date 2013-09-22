require 'sinatra'
require 'sinatra/reloader'

secret = rand(101)

get '/' do
	"The SECRET NUMBER is #{secret}"
end