require 'net/http'
require 'open-uri'
require 'json'

class GetFoods

  URL = "https://raw.githubusercontent.com/hfg-gmuend/openmoji/master/data/openmoji.json"

  def get_foods
    uri = URI.parse(URL)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def food_school
        food_array = []
        # we use the JSON library to parse the API response into nicely formatted JSON
        foods = JSON.parse(self.get_foods)
        foods.collect do |food|
            food_array << [food["hexcode"],food["emoji"],food["annotation"],food["subgroups"],food["tags"],rand(5..30)] if food["group"] == "food-drink"
        food_array
        end
  end 
end

