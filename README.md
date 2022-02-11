# README


This is a Ruby on Rails API project that calls the API at https://bpdts-test-app.herokuapp.com and returns a JSON containing all of the users whose location is listed as London, and all of the users who are within 50 miles of central London (based on their latitude and longitude using the haversine formula). 

Tests have been written using Rspec to check the response of the API call

The endpoint can be reached here: https://ed-bent-bpdts.herokuapp.com/api/v1/users
