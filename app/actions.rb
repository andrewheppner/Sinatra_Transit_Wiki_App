
# Homepage (Root path)
set sessions: true

get '/' do 
  erb :index
end

get '/users/new' do
  @user = User.new
  erb :'/users/new'
end

post '/user' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password]
    )
  @user.errors.add[:password, "fields must match!"] if params[:password] != params[:password_confirm]
  if @user.save
    redirect '/'
  else
    erb :'/users/new'
  end

end