
# Homepage (Root path)
set sessions: true

helpers do 

  def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    request.referer.starts_with?(settings.domain_name) ? URI(request.referer).path : '/'
  end

end

before do
  @flash = session[:flash]
  session[:flash] = nil
  @user ||= User.new
end

get '/' do 
  erb :index
end

get '/users/new' do
 erb :'users/new'
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
    session[:flash] = @user.errors.full_messages
    redirect '/users/new'
  end
end

post "/login" do
  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:user_id] = @user.id 
  else
    session[:flash] = ['The username or password is incorrect! Sign in unsuccessful!']
  end
  redirect authenticate
end 

post "/logout" do 
  current_user = nil
  session.clear
  redirect '/'
end
