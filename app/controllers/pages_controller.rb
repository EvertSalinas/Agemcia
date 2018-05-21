class PagesController < ApplicationController
  before_action :authenticate_user!, :set_user

  def dashboard
  end

end
