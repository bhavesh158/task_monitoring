class TeamController < ApplicationController
  def index
    @my_teams = current_user.teams
  end
end
