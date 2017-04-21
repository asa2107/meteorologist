require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    url_temp_1 = @street_address.gsub(/ /,'+')
    url_1="http://maps.googleapis.com/maps/api/geocode/json?address=#{url_temp_1}&sensor=false"
    raw_data_1 = open(url_1).read
    parsed_data_1 = JSON.parse(open(url_1).read)
    lat = parsed_data_1["results"][0]["geometry"]["location"]["lat"]
    lng = parsed_data_1["results"][0]["geometry"]["location"]["lng"]

    url_2="https://api.darksky.net/forecast/5bc6b189445b60dfb3e3db7d89489734/#{lat},#{lng}"
    raw_data_2 = open(url_2).read
    parsed_data_2 = JSON.parse(open(url_2).read)

    @current_temperature = parsed_data_2["currently"]["temperature"]

    @current_summary = parsed_data_2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_2["daily"]["summary"]

    #@current_temperature = "Replace this string with your answer."

    #@current_summary = "Replace this string with your answer."

    #@summary_of_next_sixty_minutes = "Replace this string with your answer."

    #@summary_of_next_several_hours = "Replace this string with your answer."

    #@summary_of_next_several_days = "Replace this string with your answer."

    render("meteorologist/street_to_weather.html.erb")
  end
end
