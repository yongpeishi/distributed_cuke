require 'rest_client'

def get_scenario
  #RestClient.get('http://192.168.1.6:4567/scenario')
  RestClient.get('http://localhost:1337/scenario')
end

def post_passed_result scenario, output
  RestClient.post('http://localhost:1337/passed', task: scenario, output: 'passed')
end

def post_failed_result scenario, output
  RestClient.post('http://localhost:1337/failed', task: scenario, output: output)
end

while not (scenario = get_scenario).empty?
  output = `cucumber #{scenario} -r features --no-color`

  $?.to_i == 0 ? post_passed_result(scenario, output) : post_failed_result(scenario, output)
end

puts "done"

