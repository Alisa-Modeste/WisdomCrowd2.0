class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def ensure_logged_in
    unless self.current_user
      flash[:notice] = "You need to be logged in to do that"
      redirect_to new_session_url
    end
  end

  def format_tags(tags)
    p "I'm in the formatter"
    tags.gsub('</', '<\/').split(",")
  end
end
