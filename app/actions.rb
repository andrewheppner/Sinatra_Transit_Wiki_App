
# Homepage (Root path)
set sessions: true


get '/register' do
  @user = User.new
  erb :'register'
end

post '/register' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    new_password: params[:password],
    new_password_confirmation: params[:password_confirmation]
    )
  if @user.save
    redirect '/register'
  else
    erb :'/register'
  end
end