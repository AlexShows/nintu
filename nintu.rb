require 'sinatra'
require 'json'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'w'))

ActiveRecord::Base.establish_connection(
	:adapter  => 'sqlite3',
	:database => 'nintu.db'
)

ActiveRecord::Schema.define do
	unless ActiveRecord::Base.connection.tables.include? 'experiments'
		create_table :experiments do |table|
			table.column :name,	:string
			table.column :date,	:string
		end
	end
	
	unless ActiveRecord::Base.connection.tables.include? 'observations'
		create_table :observations do |table|
			table.column :experiment_id,:integer
			table.column :temperature,	:integer
			table.column :input,		:integer
			table.column :output,		:integer
		end
	end
end

class Experiment < ActiveRecord::Base
	has_many :observations
end

class Observation < ActiveRecord::Base
	belongs_to :experiment
end

unless Experiment.find_by_name('heat')
	experiment = Experiment.create(
		:name	=> 'heat',
		:date	=> 'August 13th, 2013'
	)
	
	experiment.observations.create(:experiment_id => 0, :temperature => 45, :input => 1, :output => 3)
	experiment.observations.create(:experiment_id => 0, :temperature => 44, :input => 3, :output => 15)
	experiment.observations.create(:experiment_id => 0, :temperature => 43, :input => 5, :output => 12)
	experiment.observations.create(:experiment_id => 0, :temperature => 44, :input => 16, :output => 39)
	experiment.observations.create(:experiment_id => 0, :temperature => 35, :input => 12, :output => 13)
	experiment.observations.create(:experiment_id => 0, :temperature => 42, :input => 11, :output => 10)
	experiment.observations.create(:experiment_id => 0, :temperature => 37, :input => 3, :output => 7)
	experiment.observations.create(:experiment_id => 0, :temperature => 38, :input => 5, :output => 8)
	experiment.observations.create(:experiment_id => 0, :temperature => 40, :input => 1, :output => 5)
	experiment.observations.create(:experiment_id => 0, :temperature => 42, :input => 6, :output => 2)
end

unless Experiment.find_by_name('cool')
	experiment = Experiment.create(
		:name	=> 'cool',
		:date	=> 'February 7th, 2014'
	)
	
	experiment.observations.create(:experiment_id => 0, :temperature => 45, :input => 31, :output => 3)
	experiment.observations.create(:experiment_id => 0, :temperature => 44, :input => 43, :output => 15)
	experiment.observations.create(:experiment_id => 0, :temperature => 43, :input => 35, :output => 12)
	experiment.observations.create(:experiment_id => 0, :temperature => 44, :input => 46, :output => 39)
	experiment.observations.create(:experiment_id => 0, :temperature => 35, :input => 52, :output => 13)
	experiment.observations.create(:experiment_id => 0, :temperature => 42, :input => 61, :output => 10)
	experiment.observations.create(:experiment_id => 0, :temperature => 37, :input => 33, :output => 7)
	experiment.observations.create(:experiment_id => 0, :temperature => 38, :input => 45, :output => 8)
	experiment.observations.create(:experiment_id => 0, :temperature => 40, :input => 21, :output => 5)
	experiment.observations.create(:experiment_id => 0, :temperature => 42, :input => 46, :output => 2)
end

get '/experiment/:name' do |experiment_name|
	content_type :json
	experiment = Experiment.find_by_name(experiment_name)
	if experiment
		observation = experiment.observations.find_by_temperature(45)
		{ :name			=> experiment.name,
		  :date 		=> experiment.date,
		  :temperature 	=> observation.temperature,
		  :input 		=> observation.input,
		  :output 		=> observation.output
		}.to_json
	else
		{ :response => "Error: No record found for experiment #{experiment_name}."}.to_json
	end	
end

get '/observations/:name/:number' do |experiment_name, observation_number|
	experiment = Experiment.find_by_name(experiment_name)
	if experiment
		observation = experiment.observations.last(observation_number)
		observation.each do |obs|
			"Observation temperature #{obs.temperature}, input #{obs.input}, output #{obs.output}."
		end
		"Done"
	else
		"Error."
	end	
end

get '/' do
	content_type :json 
	{ :application => 'Nintu Experiment Information Server', :version => 'v0.1-103' }.to_json
end
