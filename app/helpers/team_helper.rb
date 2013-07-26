module TeamHelper

  def is_team_lead?(team)
    user_type = current_user.get_current_user_type(team)
    user_type == "Team Lead" ? true : false
  end
  
  def is_user_is_team_lead_team?(team)
    user_type = team.get_user_type(current_user.id)
    user_type == "Team Lead" ? true : false
  end

end
