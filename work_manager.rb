output = `cucumber features --dry-run --expand --no-color -r features`
scenario_lines = output.split("\n").select { |line| !!line.match(/^(\s+)?Scenario:/) }
scenario_locations = scenario_lines.map { |line| line.split("#")[1].strip }
puts scenario_locations
