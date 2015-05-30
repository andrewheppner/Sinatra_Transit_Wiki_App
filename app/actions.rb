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

get '/pics/new' do 
  erb :'pics/new'
end

post '/pics/new' do
  #TODO: test with user logged in
  current_user
  @pic = Pic.new(
    user_id: params[:user_id],
    city_id: params[:city_id],
    path: params[:path],
    pic_title: params[:pic_title]
    )
  if @pic.save
    #TODO: redirect to city page
    redirect '/pics/show' 
  else
    erb :'/pics/new'
  end
end

get '/cities/:city_id/pics/:id' do
  @city = City.find(params[:city_id])
  @pic = @city.pics.find(params[:id])
  erb :'/pics/show'
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

get '/users/show' do
  erb :'users/show'
end

post '/users/show' do 
  current_user.pic_url = params[:pic_url]
  if current_user.save
    redirect '/users/show' 
  else
    erb :'/users/show'
  end
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
    session[:flash] = ['There is no page created for this city! Do you want to create a new one?']
    redirect '/cities/new'
  end

end

get '/cities/:id' do 
  @city = City.find(params[:id])
  erb :'cities/show'
end





