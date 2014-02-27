require 'sinatra'
require 'CSV'
require "pry"

def get_team_information
  team_information = []
  CSV.foreach('lackp_starting_rosters.csv', headers: true) do |rows|
    team_information << rows.to_hash
  end
  return team_information
end

def team_names
  team_names = []
  get_team_information.each do |hash|
    team_names << hash["team"]
  end
  team_names = team_names.uniq
end

def player_info(teams)
  team = []
  get_team_information.each do |hash|
    if hash["team"] == teams
      team << hash.values
    end
  end
  return team
end

get '/' do
  @team_names = team_names
  erb :index
end

team_names.each do |teams|
  get "/#{URI::encode(teams)}" do
    @players = player_info(teams)
    erb :team
  end
end

# [{"first_name"=>"Bart", "last_name"=>"Simpson", "position"=>"Catcher", "team"=>"Simpson Slammers"}
# {"first_name"=>"Homer", "last_name"=>"Simpson", "position"=>"Pitcher", "team"=>"Simpson Slammers"}
# {"first_name"=>"Marge", "last_name"=>"Simpson", "position"=>"1st Base", "team"=>"Simpson Slammers"}
# {"first_name"=>"Lisa", "last_name"=>"Simpson", "position"=>"2nd Base", "team"=>"Simpson Slammers"}
# {"first_name"=>"Ned", "last_name"=>"Flanders", "position"=>"3rd Base", "team"=>"Simpson Slammers"}
# {"first_name"=>"Barney", "last_name"=>"Grumble", "position"=>"Shortstop", "team"=>"Simpson Slammers"}
# {"first_name"=>"Monty", "last_name"=>"Burns", "position"=>"Right Field", "team"=>"Simpson Slammers"}
# {"first_name"=>"Waylon", "last_name"=>"Smithers", "position"=>"Center Field", "team"=>"Simpson Slammers"}
# {"first_name"=>"Clancy", "last_name"=>"Wiggum", "position"=>"Left Field", "team"=>"Simpson Slammers"}
# {"first_name"=>"George", "last_name"=>"Jetson", "position"=>"Catcher", "team"=>"Jetson Jets"}
# {"first_name"=>"Jane", "last_name"=>"Jetson", "position"=>"Pitcher", "team"=>"Jetson Jets"}
# {"first_name"=>"Judy", "last_name"=>"Jetson", "position"=>"1st Base", "team"=>"Jetson Jets"}
# {"first_name"=>"Elroy", "last_name"=>"Jetson", "position"=>"2nd Base", "team"=>"Jetson Jets"}
# {"first_name"=>"Astro", "last_name"=>"Jetson", "position"=>"3rd Base", "team"=>"Jetson Jets"}
# {"first_name"=>"Orbitty", "last_name"=>"Jetson", "position"=>"Shortstop", "team"=>"Jetson Jets"}
# {"first_name"=>"Cosmo", "last_name"=>"Spacely", "position"=>"Right Field", "team"=>"Jetson Jets"}
# {"first_name"=>"Rosie", "last_name"=>"Jetson", "position"=>"Center Field", "team"=>"Jetson Jets"}
# {"first_name"=>"Stella", "last_name"=>"Spacely", "position"=>"Left Field", "team"=>"Jetson Jets"}
# {"first_name"=>"Fred", "last_name"=>"Flinestone", "position"=>"Catcher", "team"=>"Flinestone Fire"}
# {"first_name"=>"Wilma", "last_name"=>"Flinestone", "position"=>"Pitcher", "team"=>"Flinestone Fire"}
# {"first_name"=>"Dino", "last_name"=>"Flinestone", "position"=>"1st Base", "team"=>"Flinestone Fire"}
# {"first_name"=>"Barney", "last_name"=>"Rubble", "position"=>"2nd Base", "team"=>"Flinestone Fire"}
# {"first_name"=>"Betty", "last_name"=>"Rubble", "position"=>"3rd Base", "team"=>"Flinestone Fire"}
# {"first_name"=>"Pebbles", "last_name"=>"Flinestone", "position"=>"Shortstop", "team"=>"Flinestone Fire"}
# {"first_name"=>"Joe", "last_name"=>"Rockhead", "position"=>"Right Field", "team"=>"Flinestone Fire"}
# {"first_name"=>"Sam", "last_name"=>"Slagheap", "position"=>"Center Field", "team"=>"Flinestone Fire"}
# {"first_name"=>"Sylvester", "last_name"=>"Slate", "position"=>"Left Field", "team"=>"Flinestone Fire"}
# {"first_name"=>"Lois", "last_name"=>"Griffin", "position"=>"Catcher", "team"=>"Griffin Goats"}
# {"first_name"=>"Brian", "last_name"=>"Griffin", "position"=>"Pitcher", "team"=>"Griffin Goats"}
# {"first_name"=>"Peter", "last_name"=>"Griffin", "position"=>"1st Base", "team"=>"Griffin Goats"}
# {"first_name"=>"Stewie", "last_name"=>"Griffin", "position"=>"2nd Base", "team"=>"Griffin Goats"}
# {"first_name"=>"Chris", "last_name"=>"Griffin", "position"=>"3rd Base", "team"=>"Griffin Goats"}
# {"first_name"=>"Glenn", "last_name"=>"Quagmire", "position"=>"Shortstop", "team"=>"Griffin Goats"}
# {"first_name"=>"Cleveland", "last_name"=>"Brown", "position"=>"Right Field", "team"=>"Griffin Goats"}
# {"first_name"=>"Tom", "last_name"=>"Tucker", "position"=>"Center Field", "team"=>"Griffin Goats"}
# {"first_name"=>"Meg", "last_name"=>"Griffin", "position"=>"Left Field", "team"=>"Griffin Goats"}]
