output = `cucumber features --dry-run --expand --no-color -r features`
scenario_lines = output.split("\n").select { |line| !!line.match(/^(\s+)?Scenario:/) }
scenario_locations = scenario_lines.map { |line| line.split("#")[1].strip }
total_number_of_scenario = scenario_locations.length
results = {}
has_failed_scenario = false
failed_tests = []


require 'sinatra'
set :bind, '0.0.0.0'
set :logging, false

get '/scenario' do
  scenario_locations.pop
end

post '/result' do
  if params[:output].include? 'failed'
    has_failed_scenario = true
    failed_tests << params[:output]
  end

  results[ params[:scenario] ] = params[:output]

  trap("INT") do
    puts "********************************** trap int"
    exit! 1
  end

  if results.length == total_number_of_scenario
    if has_failed_scenario
      puts failed_tests
    end
    Process.kill 'INT', Process.pid

    #TODO: better way of handling this? return 200 so that the server wont complaint
    return 200
  end
end

get '/result' do
  results.inspect
end

