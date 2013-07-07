require 'rest_client'


scenario = RestClient.get('http://localhost:4567/scenario')

puts `cucumber #{scenario} -r features --no-color`
