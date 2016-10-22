require 'sinatra'
require 'sinatra/reloader'

x = rand(0..100)

get '/' do
	"The secret number is #{x}"
end