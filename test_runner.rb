require 'rest_client'

SERVER_IP = ARGV.first

def get_scenario
  RestClient.get("http://#{SERVER_IP}:1337/scenario")
end

def post_passed_result scenario, output
  RestClient.post("http://#{SERVER_IP}:1337/passed", task: scenario, output: output)
end

def post_failed_result scenario, output
  RestClient.post("http://#{SERVER_IP}:1337/failed", task: scenario, output: output)
end

while not (scenario = get_scenario).empty?
  puts scenario
  output = `cucumber #{scenario} -r features --no-color`

  $?.to_i == 0 ? post_passed_result(scenario, output) : post_failed_result(scenario, output)
end

puts "done"

