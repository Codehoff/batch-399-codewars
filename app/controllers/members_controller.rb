class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!
  
  
  def index
    @members = Member.all
  end


  def show
    require "json"
    require 'nokogiri'
    require "open-uri" 

    url = "https://www.codewars.com/api/v1/users/#{@member.username}" 
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)

    @ruby_score = @member.score
    @rank = @member.rank.split("")[0].to_i
    @kyu = @member.rank
    
    @percentage = 0
    @color = nil
    case @rank
    when 8
      @percentage = (@ruby_score * 100 / 20).round(0)
      @color = "#CCCCCC"
    when 7 
      @percentage = ((@ruby_score - 20) * 100 / (76.0 - 20)).round(0) 
      @color = "#CCCCCC"
    when 6 
      @percentage = ((@ruby_score - 76) * 100 / (229.0 - 76)).round(0) 
      @color = "#ECB613"
    when 5 
      @percentage = ((@ruby_score - 229) * 100 / (643.0 - 229)).round(0)
      @color = "#ECB613" 
    when 4 
      @percentage = ((@ruby_score - 643) * 100 / (1768.0 - 643)).round(0)
      @color = "#3C7EBB"
    when 3 
      @percentage = ((@ruby_score - 1768) * 100 / (4829.0 - 1768)).round(0) 
      @color = "#3C7EBB"
    when 2
      @percentage = ((@ruby_score - 4829) * 100 / (13147.0 - 4829)).round(0)
      @color = "#866CC7"
    when 1
      @color = "#866CC7"
    end
  
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:first_name, :last_name, :username)
    end
end
