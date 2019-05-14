require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get("https://www.swapi.co/api/people?search=#{character_name.split(" ").join("+")}")
  response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  # binding.pry
  if response_hash["count"] == 0
    return []
  else
    character_details = get_character_details(response_hash)
    get_films_for_character(character_details)
  end
end

def get_character_details(response_hash)
  response_hash["results"].first
end

def get_films_for_character(character_details)
  character_details["films"].sort.map{|film_api| get_film_title_from_api(film_api)}
end

def get_film_title_from_api(film_api)
  film_response = JSON.parse(RestClient.get(film_api))["title"]
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each{|film| puts "#{film}"}
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
# binding.pry