class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    auth = request.env['omniauth.auth']
    token = auth['credentials']['token']
    session[:fb_access_token] = token
    session[:fb_user_uid] = auth['uid']
    logger.debug "facebook session in connect: #{session[:fb_access_token].inspect}"
    #client = FBGraph::Client.new(:client_id => GRAPH_APP_ID, :secret_id => GRAPH_SECRET, :token => token)
    #client.inspect
    #user = client.selection.me.info!
    #client.selection.user(user[:id]).feed.publish!(:message => 'test message', :name => 'test name')
    #render :json => client.selection.me.info!
  
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    @user.save!
    #if @user.persisted?
    sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    #else
      #session["devise.facebook_data"] = request.env["omniauth.auth"]
      #redirect_to new_user_registration_url
    #end
  end
end