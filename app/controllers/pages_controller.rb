class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    require "json" 
    require "open-uri" 

    url = "https://www.codewars.com/api/v1/users/Codehoff" 
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)

    @ruby_score = user["ranks"]["overall"]["score"]
    @rank = (user["ranks"]["overall"]["rank"]).to_i * -1
    @kyu = user["ranks"]["overall"]["name"]

    @percentage = 5

    case @rank
    when 8
      @percentage = (@ruby_score * 100 / 20).round(0)
    when 7 
      @percentage = ((@ruby_score - 20) * 100 / (76.0 - 20)).round(0) 
    when 6 
      @percentage = ((@ruby_score - 76) * 100 / (229.0 - 76)).round(0) 
    when 5 
      @percentage = ((@ruby_score - 229) * 100 / (643.0 - 229)).round(0) 
    when 4 
      @percentage = ((@ruby_score - 643) * 100 / (1768.0 - 643)).round(0) 
    when 3 
      @percentage = ((@ruby_score - 1768) * 100 / (4829.0 - 1768)).round(0) 
    when 2
      @percentage = ((@ruby_score - 4829) * 100 / (13147.0 - 4829)).round(0) 
    end

  end




end
