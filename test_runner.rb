require 'rest_client'

def get_scenario
  RestClient.get('http://localhost:4567/scenario')
end


while not (scenario = get_scenario).empty?
  puts `cucumber #{scenario} -r features --no-color`
end

puts "done"

