File.open('work_manager.pid', 'w') {|f| f.write Process.pid }

output = `cucumber features --dry-run --expand --no-color -r features`
scenario_lines = output.split("\n").select { |line| !!line.match(/^(\s+)?Scenario:/) }
scenario_locations = scenario_lines.map { |line| line.split("#")[1].strip }
total_number_of_scenario = scenario_locations.length
results = {}
has_failed_scenario = false

require 'sinatra'
set :bind, '0.0.0.0'
set :logging, false

get '/scenario' do
  scenario_locations.pop
end

post '/result' do
  if params[:output].include? 'failed'
    has_failed_scenario = true
  end
  results[ params[:scenario] ] = params[:output]
  if results.length == total_number_of_scenario
    Process.kill 'TERM', File.read('work_manager.pid').to_i
    return 200
  end
end

get '/result' do
  results.inspect
end

