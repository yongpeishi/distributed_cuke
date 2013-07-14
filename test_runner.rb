require 'rest_client'

def get_scenario
  RestClient.get('http://192.168.1.6:4567/scenario')
end

def post_result scenario, output
  RestClient.post('http://192.168.1.6:4567/result', scenario: scenario, output: output)
end

while not (scenario = get_scenario).empty?
  output = `cucumber #{scenario} -r features --no-color`

  post_result(scenario, output)
end

puts "done"

