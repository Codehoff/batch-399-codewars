class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    require "json"
    require "open-uri" 
    Member.all.map do |member|
      url = "https://www.codewars.com/api/v1/users/#{member.username}" 
      user_serialized = open(url).read 
      user = JSON.parse(user_serialized)

      member.update(score: user["ranks"]["overall"]["score"])
      member.update(honor: user["honor"])
      member.update(rank: "#{(user["ranks"]["overall"]["rank"]).to_i * -1} kyu")

    end

  end




end
