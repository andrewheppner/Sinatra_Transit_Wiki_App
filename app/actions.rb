set sessions: true

helpers do 
  def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
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
  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:user_id] = user.id 
    redirect '/'
  else
    @user = User.new
    erb ((path = URI(request.referer).path).last != '/' ? path : path + 'index').to_sym
  end
end 

post "/logout" do 
  current_user = nil
  session.clear
  redirect '/'
end
