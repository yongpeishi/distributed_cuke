scenario_locations = STDIN.read.split("\n")
scenario_output = scenario_locations.map do |scenario|
                    `cucumber #{scenario} -r features --no-color`
                  end
puts scenario_output
