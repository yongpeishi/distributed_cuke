require 'rest_client'

SERVER_IP = ARGV.first

def get_scenario
  RestClient.get("http://#{SERVER_IP}:1337/scenario")
end

def post_passed_result scenario, output, exit_code
  RestClient.post("http://#{SERVER_IP}:1337/passed", task: scenario, output: output, exit_code: exit_code)
end

def post_failed_result scenario, output, exit_code
  output = output.split("\n")[1..-4].join("\n")
  RestClient.post("http://#{SERVER_IP}:1337/failed", task: scenario, output: output, exit_code: exit_code)
end

while not (scenario = get_scenario).empty?
  puts scenario
  output = `cucumber #{scenario} -r features --no-color`

  $?.to_i == 0 ? post_passed_result(scenario, output, $?.to_i) : post_failed_result(scenario, output, $?.to_i)
end

puts "done"

