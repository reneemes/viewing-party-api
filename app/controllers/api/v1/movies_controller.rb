class Api::V1::MoviesController < ApplicationController
  def index

    conn = Faraday.new(url: "https://api.pexels.com") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.pexels[:key]
    end
    
  end
end