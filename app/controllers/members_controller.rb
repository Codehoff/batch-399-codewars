class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
    require "json"
    require "open-uri" 

    url = "https://www.codewars.com/api/v1/users/#{@member.username}" 
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)

    @ruby_score = @member.score
    @rank = @member.rank.split("")[0].to_i
    @kyu = @member.rank
    @percentage = 0
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

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
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
