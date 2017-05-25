Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  #EZ BADAGO INONGO POST EDO GET BIDERATZEAKOAN, sign_in_path ADIERAZTEAN ORRIRA BIDERATZEN DA
  root :to=>"home#index"



  #!Get bidez, sign_in deitzean, authentication_controllerreko sign_in exekutatu
  get "sign_in" => "authentication#sign_in"
  get "signed_out" => "authentication#signed_out"
  get "change_password" => "users#update_password"
  get "forgot_password" => "authentication#forgot_password"
  get "new_user" => "authentication#new_user"
  get "password_sent" => "authentication#password_sent"

  get "device/get_gps" => "device#get_gps"





#!Post bidez, sign_in deitzean, authentication_controllerreko login exekutatu
  post "sign_in" => "authentication#login"
  post "new_user" => "authentication#register"


  #Device baten eragiketen routinga
  get '/device/:id/activate_gps', to:'device#activate_GPS'
  get '/device/:id/desactivate_gps', to:'device#desactivate_GPS'
  get '/device/:id/activate_alarm', to:'device#activate_alarm'
  get '/device/:id/desactivate_alarm', to:'device#desactivate_alarm'
  get '/device/:id', to:'device#selected_device', as: 'current_device'

  #GPS Date

  get '/device/:id/:year/:month/:day', to: 'gps#show_locations'

  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
end
