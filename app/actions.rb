
# Homepage (Root path)
set sessions: true

helpers do 

  def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    request.referer.starts_with?(settings.domain_name) ? URI(request.referer).path : '/'
  end

  def sign_in
    session[:user_id] = @user.id 
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
    sign_in
    redirect '/'
  else
    session[:flash] = @user.errors.full_messages
    redirect '/users/new'
  end
end

post "/login" do
  @user = User.find_by(email: params[:email])
  if @user && @user.authenticate(params[:password])
    sign_in
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

post '/search' do 
  @cities = City.where(name: params[:city_name])
 
  if @cities.first
    if @cities.length == 1
      redirect "/cities/#{@cities[0].id}"
    else
      erb :'cities/pick_city'
    end
  else

  end

end

get '/cities/:id' do 
  @city = City.find(params[:id])
  erb :'cities/show'
end





