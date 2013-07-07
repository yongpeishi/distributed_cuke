namespace :cucumber do
  task :one_by_one do
    output = `cucumber features --dry-run --expand --no-color -r features`
    scenario_lines = output.split("\n").select { |line| !!line.match(/^(\s+)?Scenario:/) }
    scenario_locations = scenario_lines.map { |line| line.split("#")[1] }
    scenario_output = scenario_locations.map do |scenario|
                        `cucumber #{scenario} -r features --no-color`
                      end
    puts scenario_output.inspect
  end
end
