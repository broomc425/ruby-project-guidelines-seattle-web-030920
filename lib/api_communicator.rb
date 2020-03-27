require 'rest-client'
require 'json'
require 'pry'

def get_nba_player_from_api(character_name)
  #make the web request
  response_string = RestClient.get('https://www.balldontlie.io/api/v1/players/237')
  response_hash = JSON.parse(response_string)

  binding.pry
  

end

