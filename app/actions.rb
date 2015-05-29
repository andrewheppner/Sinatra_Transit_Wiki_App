
# Homepage (Root path)
set sessions: true

helpers do 

  def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end

get '/' do 
  erb :index
end

get '/users/new' do
  @user = User.new
  erb :'/users/new'
end

post '/users' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password],
    password_confirmation: params[:password_confirmation]
    )
  if @user.save
    redirect '/'
  else
    erb :'/users/new'
  end

end

post "/login" do
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id 
    redirect '/'
  else
    redirect '/users/new'
    # erb URI(request.referer).path.to_sym
  end
end 

post "/logout" do 
  current_user = nil
  session.clear
  redirect '/'
end
