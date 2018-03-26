class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_user
    @user = current_user
  end

  def set_quotations
    @quotations = Quotation.all
  end

  def set_current_quotation
    @quotation = Quotation.last
  end

end
