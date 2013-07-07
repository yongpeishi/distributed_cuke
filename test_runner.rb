require 'rest_client'

scenario = RestClient.get('http://localhost:4567/scenario')

if scenario.empty?
  puts "No more scenario to run. yay!"
else
  puts `cucumber #{scenario} -r features --no-color`
end
