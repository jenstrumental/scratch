class UsersController < ApplicationController
  before_filter :require_beta_access

  def show
  	@user = User.find(params[:id])
  end
  
end