
class AuthenticationController < ApplicationController


  #!logineko render actionen bidez, hau exekutatuko da
  def sign_in
    @user = User.new
  end

  #!Sign out egiteko
  def signed_out
    session[:email] = nil
    flash[:notice] = "You have been signed out."
    redirect_to :root
  end

  def new_user
    @user = User.new
  end

  #!Login egitean, hona etorriko da

  def login
    email = params[:user][:email]
    password = params[:user][:password]

    user = User.authenticate_by_email(email, password)


    if user
      session[:email] = user.email
      flash[:notice] = 'Welcome.'
      redirect_to :root
    else
      flash.now[:error] = 'Unknown user. Please check your username and password.'
      render :action => "sign_in"
    end

  end
#!Autentifikazioa kontrolerrak egiten du automatikoki, eremuen azterketa osoa.
  def register
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      session[:email] = @user.email
      flash[:notice] = 'Welcome.'
      redirect_to :root
    else
      render :action => "new_user"
    end
  end


  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end


end