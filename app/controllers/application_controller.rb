class ApplicationController < ActionController::Base
  protect_from_forgery

   def facebook_user
    (session[:fb_access_token] && session[:fb_user_uid]) ? FBGraph::Client.new(:client_id => ENV['APP_ID'], :secret_id => ENV['APP_SECRET'], :token => session[:fb_access_token]).selection.me.info! : nil
  end

  def require_beta_access
    unless user_signed_in? && current_user.has_beta_access?
    	redirect_to :controller => "home", :action => "index"
    end
  end

end
