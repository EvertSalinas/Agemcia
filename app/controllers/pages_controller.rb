class PagesController < ApplicationController
  before_action :authenticate_user!, :set_user

  def dashboard
    @quotations = Quotation.last(5)
  end

end
