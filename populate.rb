require 'faraday'
response = Faraday.get(url)
json = response.body