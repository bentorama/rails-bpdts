require 'open-uri'

class Api::V1::UsersController < ApplicationController
  def index
    # retrieve all the users whose city is London and store in an array called users
    users = retrieve_users('city/London/users')
    # retrieve all the users and store in an array called all_users
    all_users = retrieve_users('users')
    # iterate over all_users and push to the users array if distance is <= 50 miles to London
    all_users.each { |user| users << user if distance_less_than_50?(user) }
    render json: users, status: 200
  end

  private

  # Charing Cross Coordinates in radians
  LAT_LONDON = 51.5073 * Math::PI / 180
  LON_LONDON = -0.12755 * Math::PI / 180

  def retrieve_users(path)
    # retrieve an array of users from the API dpending on the path
    url = "https://bpdts-test-app.herokuapp.com/#{path}"
    users_serialized = URI.parse(url).open.read
    JSON.parse(users_serialized)
  end

  def distance_less_than_50?(user)
    # user coordinates in radians. 
    # Not all entries are Strings rather than Floats so call .to_f to make sure we're using floats
    lat_user = user['latitude'].to_f * Math::PI / 180
    lon_user = user['longitude'].to_f * Math::PI / 180
    # longitude and latitude distances
    d_lon = LON_LONDON - lon_user
    d_lat = LAT_LONDON - lat_user
    # return is the calculated distance less than or equal to 50 miles
    distance(lat_user, d_lat, d_lon) <= 50
  end

  def distance(lat_user, d_lat, d_lon)
    # calculate the distance between the the user and Charing Cross using the Haversine formula
    a = Math.sin(d_lat / 2)**2 + Math.cos(LAT_LONDON) * Math.cos(lat_user) * Math.sin(d_lon / 2)**2
    2 * 3956 * Math.asin(Math.sqrt(a.abs))
  end
end
