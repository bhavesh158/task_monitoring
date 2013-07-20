class TeamsController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @my_teams = current_user.teams
  end

end
