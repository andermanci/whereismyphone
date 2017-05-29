
class DeviceController < ApplicationController
  helper ApplicationHelper

  require 'firebase'
  require 'gcm'

  def selected_device

    if request.get?

      @device = Device.new
      device= Device.find((params[:id]))
      if device
        #This function will get all the days, where the selected device send a GPS location

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

  def get_gps

    if current_device

      require 'json'
      require 'gon'
      # @proba = 'kaixo'
      @device_gps2 = Location.where(device_id:session[:device]).select(:created_at, :long, :lat, :id).map{|c| {lat: c.lat.to_f, :lng => c.long.to_f, :day => c.created_at.strftime("%Y/%m/%d"), :hour => c.created_at.strftime("%H:%M:%S"), :id => c.id, :infowindow => c.created_at.strftime("%H:%M:%S")}}.uniq

      @device_gps = @device_gps2.to_json

      print(@device_gps)

      gon.device_gps = @device_gps


    end

  end



  def activate_GPS
    if current_device

      require 'fcm'
      fcmServer = FCM.new('AAAAUm2fpt4:APA91bHWeq-i1Dfc_ZgpQKqL5TIM3MBvXlMC4H8SVi8CDxvJKSEHHWgQvroxBO02XP0MGRZOZ6Y94Mz9auqfW_YzPzi4m0N7UUgvQDhsi0vLKsDKRWi5HpxuWS_nXxwiH0cNZs8fbhe9')

      options = {}
      options[:notification] = {}
      options[:notification][:title] = 'GPS'
      options[:notification][:body] = 'Connect'
      options[:content_available] = true
      options[:notification][:sound] = "default"
      options[:notification][:click_action] = "FCM_PLUGIN_ACTIVITY"
      options[:data] = {}
      options[:data][:gps] = true
      options[:priority] = 'high'

      token = current_device.token
      responseServer = fcmServer.send([token], options)

      session[:GPS]= 'yes'
      redirect_to current_device_path
    else
      redirect_to :root
    end

  end




  def desactivate_GPS
    if current_device

      require 'fcm'
      fcmServer = FCM.new('AAAAUm2fpt4:APA91bHWeq-i1Dfc_ZgpQKqL5TIM3MBvXlMC4H8SVi8CDxvJKSEHHWgQvroxBO02XP0MGRZOZ6Y94Mz9auqfW_YzPzi4m0N7UUgvQDhsi0vLKsDKRWi5HpxuWS_nXxwiH0cNZs8fbhe9')

      options = {}
      options[:notification] = {}
      options[:notification][:title] = 'GPS'
      options[:notification][:body] = 'Disconnect'
      options[:content_available] = true
      options[:notification][:sound] = "default"
      options[:notification][:click_action] = "FCM_PLUGIN_ACTIVITY"
      options[:data] = {}
      options[:data][:gps] = false
      options[:priority] = 'high'

      token = current_device.token
      responseServer = fcmServer.send([token], options)

      session[:GPS]= 'no'
      redirect_to current_device_path
    else
      redirect_to :root
    end
  end

  def activate_alarm
    if current_device

      require 'fcm'
      fcmServer = FCM.new('AAAAUm2fpt4:APA91bHWeq-i1Dfc_ZgpQKqL5TIM3MBvXlMC4H8SVi8CDxvJKSEHHWgQvroxBO02XP0MGRZOZ6Y94Mz9auqfW_YzPzi4m0N7UUgvQDhsi0vLKsDKRWi5HpxuWS_nXxwiH0cNZs8fbhe9')

      options = {}
      options[:notification] = {}
      options[:notification][:title] = 'Alarm'
      options[:notification][:body] = 'sound'
      options[:content_available] = true
      options[:notification][:sound] = 'siren.mp3'
      options[:notification][:click_action] = "FCM_PLUGIN_ACTIVITY"
      options[:data] = {}
      options[:priority] = 'high'

      token = current_device.token
      responseServer = fcmServer.send([token], options)

      redirect_to current_device_path
    else
      redirect_to :root
    end

  end



end
