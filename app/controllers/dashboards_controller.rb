class DashboardsController < ApplicationController
  def show
    @user = current_user
    @projects = @user.projects
    @contributions = @user.projects_contributions
    @character = compting_writing_character
    @random_user = User.first
    @random_user_two = User.find_by_username("george")
    @feed_list = feed_list
  end

  def compting_writing_character
    compteur = 0
    @projects.each do |project|
      compteur += project.text.content.length unless project.text.content.nil?
    end

    @user.modifications.each do |modification|
      if (modification.content_after.length - modification.content_before.length).positive?
        compteur += modification.content_after.length - modification.content_before.length
      end
    end
    return compteur
  end

  private

  def feed_list
    projects = current_user.projects + current_user.projects_contributions
    feed_list = []
    projects.each { |project|
      project.discussions.each { |discussion| feed_list << discussion }

      project.text.modifications.each { |modification| feed_list << modification }

      project.contributors.each { |contributor| feed_list << contributor }
    }
    feed_list.sort_by!{ |feed| feed.updated_at }
    return feed_list.reverse!
  end
end
