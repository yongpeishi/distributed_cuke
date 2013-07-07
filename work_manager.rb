output = `cucumber features --dry-run --expand --no-color -r features`
scenario_lines = output.split("\n").select { |line| !!line.match(/^(\s+)?Scenario:/) }
scenario_locations = scenario_lines.map { |line| line.split("#")[1].strip }
results = {}

require 'sinatra'

get '/scenario' do
  scenario_locations.pop
end

post '/result' do
  results[ params[:scenario] ] = params[:output]
end

get '/result' do
  results.inspect
end
