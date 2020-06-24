class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    require "json"
    require "open-uri" 
    Member.all.map do |member|
      url = "https://www.codewars.com/api/v1/users/#{member.username}"
      user_serialized = open(url).read 
      user = JSON.parse(user_serialized)

      url_katas = "http://www.codewars.com/api/v1/users/#{member.username}/code-challenges/completed?page=0"
      katas_serialized = open(url_katas).read 
      katas = JSON.parse(katas_serialized)

      member.update(score: user["ranks"]["overall"]["score"])
      member.update(honor: user["honor"])
      member.update(rank: "#{(user["ranks"]["overall"]["rank"]).to_i * -1} kyu")
      member.update(completed_katas: katas["totalItems"])


    end

  end




end
