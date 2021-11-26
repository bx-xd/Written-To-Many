class DashboardsController < ApplicationController
  def show
    @user = current_user
    @projects = @user.projects
    @contributions = @user.projects_contributions
    #@character = compting_writing_character
  end

  #def compting_writing_character
    #compteur = 0
    #@projects.each do |project|
      #compteur += project.text.content.length
    #end

    #@user.modifications.each do |modification|
      #if (modification.content_after.length - modification.content_before.length).positive?
        #compteur += modification.content_after.length - modification.content_before.length
      #end
    #end
    #return compteur
  #end
end
