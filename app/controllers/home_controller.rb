class HomeController < ApplicationController
  
  #before_filter :authenticate_user!

  def index
  	if user_signed_in?
  		if current_user.has_beta_access?
  			render :template => "home/index"
  		else 
  		    render :template => "home/thanks"
  		end
  	else
  		render :template => "home/signup"
  	end
  end
end
