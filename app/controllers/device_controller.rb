
class DeviceController < ApplicationController


  require 'firebase'
  require 'gcm'

  def selected_device

    if request.get?

      @device = Device.new
      device= Device.find((params[:id]))
      if device
        #This function will get all the days, where the selected device send a GPS location
        @device_gps_days=Location.where(device_id: params[:id]).select(:created_at).map{|c| {:year => c.created_at.year,:month => c.created_at.month, :day => c.created_at.day, } }.uniq

        @device= device
        session[:device]=params[:id]
        render 'device/device'
      else
        redirect_to :root
      end
    else
      redirect_to :root
    end
  end




  def activate_GPS
    # if current_device
    #
    #   session[:GPS]= 'yes'
    #   respond_to do |format|
    #     'device/device'
    #     device.js {render js: sendPush()}
    #   end
    # else
    #     redirect_to :root
    # end




    if current_device

      require 'fcm'
      fcm = FCM.new('AIzaSyBCBYf5qLBOCjd4Nps-yKrO4-MxJyYSSHQ')
      # options = {}
      # # options = {title: 'GPS', collapse_key: 'io.cordova.whereismyphone', gps: 'activate', wasTapped: true, body: 'activate', from: '/topics/all'}
      # options = { "data": {
      #     "title": "GPS"
      # }
      #            }
      # # options = { data:{score: "123"}, collapse_key: "activate_GPS"}
      # response = fcm.send('c4l1JrhoVQA:APA91bHnqINvH71_ijYwgIA-OUoqb51gLx1T-MAghxG_1TSE0TdIWdmLA03aYB0A72oaRNNMjUqCcCv52KpOmTxslYLf1-gyoYcvK9M4O617SCdPbhTtgxD9YJ7fzC6C7r7oZIJ8HTDA',options)
      # response1 = fcm.send_notification('c4l1JrhoVQA:APA91bHnqINvH71_ijYwgIA-OUoqb51gLx1T-MAghxG_1TSE0TdIWdmLA03aYB0A72oaRNNMjUqCcCv52KpOmTxslYLf1-gyoYcvK9M4O617SCdPbhTtgxD9YJ7fzC6C7r7oZIJ8HTDA',options)
      response2 = fcm.send_with_notification_key("/topics/all",data: {message: "This is a FCM Topic Message!"})

      session[:GPS]= 'yes'
      render 'device/device'
    else
      redirect_to :root
    end

  end

  # def activate_GPS
  #   if current_device
  #
  #     require 'gcm'
  #     gcm = GCM.new(ENV['AIzaSyBCBYf5qLBOCjd4Nps-yKrO4-MxJyYSSHQ'])
  #
  #     options = {title: 'GPS', collapse_key: 'io.cordova.whereismyphone'}
  #
  #     response = gcm.send(current_device.token, options)
  #
  #     session[:GPS]= 'yes'
  #     render 'device/device'
  #   else
  #     redirect_to :root
  #   end
  #
  # end







  # def activate_GPS
  #   if current_device
  #
  #     print 'kaixo'
  #
  #     base_uri = 'https://whereismyphone-2d1c3.firebaseio.com/'
  #
  #     firebase = Firebase::Client.new({url: base_uri})
  #
  #
  #
  #     response = firebase.push("todos", { :name => 'Pick the milk', :priority => 1 })
  #     firebase.push
  #     response.success? # => true
  #     response.code # => 200
  #     response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
  #     response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'
  #
  #     session[:GPS]= 'yes'
  #     render 'device/device'
  #   else
  #     redirect_to :root
  #
  #   end
  # end

  def desactivate_GPS
    if current_device
      if session[:GPS].to_s=='yes'

        fcm = FCM.new("AAAAUm2fpt4:APA91bHWeq-i1Dfc_ZgpQKqL5TIM3MBvXlMC4H8SVi8CDxvJKSEHHWgQvroxBO02XP0MGRZOZ6Y94Mz9auqfW_YzPzi4m0N7UUgvQDhsi0vLKsDKRWi5HpxuWS_nXxwiH0cNZs8fbhe9")
        options = { collapse_key: "desactivate_GPS"}
        response = fcm.send(current_device.token, options)

        session[:GPS]= 'no'
        render 'device/device'
      else
        render 'device/device'
      end
    else
      redirect_to :root
    end
  end

  def activate_alarm
    if current_device

      fcm = FCM.new("AIzaSyAf8cH_rC19EbpWyiFRKezYcMAUG3O4gyA")
      options = { collapse_key: "activate_alarm"}
      response = fcm.send(current_device.token, options)
      session[:alarm]= 'yes'
      render 'device/device'
    else
      redirect_to :root
    end

  end

  def desactivate_alarm
    if current_device
      if session[:alarm].to_s=='yes'

        fcm = FCM.new("AIzaSyAf8cH_rC19EbpWyiFRKezYcMAUG3O4gyA")
        options = { collapse_key: "desactivate_alarm"}
        response = fcm.send(current_device.token, options)
        session[:alarm]= 'no'
        render 'device/device'
      else
        render 'device/device'
      end
    else
      redirect_to :root
    end
  end

end
