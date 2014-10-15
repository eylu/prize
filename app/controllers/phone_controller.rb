class PhoneController < ApplicationController
  layout 'phone'
  skip_before_filter :admin_auth, :only => [:prize]
  def prize
    render template: 'users/new' if cookies[:prize].nil?
    @prize = JSON.parse(cookies[:prize] || '{}')
  end
end