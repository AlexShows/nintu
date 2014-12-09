require 'json'
require 'sinatra'
require 'data_mapper'
require 'dm-migrations'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/zzz.db")

class Task
	include DataMapper::Resource
	
	property :id, 			Serial
	property :title, 		String
	property :completed,	Boolean
	property :description,	String
end

DataMapper.finalize

if File.exists?("#{Dir.pwd}/zzz.db")
	Task.auto_upgrade!
else
	Task.auto_upgrade!
end

#@Task = Task.create(
#	:title			=> "Foo",
#	:description	=> "Bar"
#)

get '/api/tasks' do
	Task.all.to_json
end

get '/api/tasks/:id' do
	t = Task.get(params[:id])
	if t.nil?
		halt 404
	end
	t.to_json
end

post '/api/tasks' do
	body = JSON.parse request.body.read
	t = Task.create(
		id:				89,
		title:			body['title'],
		completed:		false,
		description:	body['description']
	)
	status 201
	t.to_json
end

put '/api/tasks/:id' do
	body = JSON.parse request.body.read
	t = Task.get(params[:id])
	if t.nil?
		halt 404
	end
	halt 500 unless Task.update(
		title:			body['title'],
		description:	body['description']
	)
	t.to_json
end

delete '/api/tasks/:id' do
	t = Task.get(params[:id])
	if t.nil?
		halt 404
	end
	halt 500 unless t.destroy
end
