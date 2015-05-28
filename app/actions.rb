
# Homepage (Root path)
set sessions: true

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