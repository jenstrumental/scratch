class HomeController < ApplicationController
  
  #before_filter :authenticate_user!

  def index
  	if user_signed_in?
  		render :template => "home/thanks"
  	else
  		render :template => "home/signup"
  	end
  end
end
