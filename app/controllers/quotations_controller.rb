class QuotationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quotations

  def index
    @pending_quotations = @quotations.pending
    @cancelled_quotations  = @quotations.cancelled
    @closed_quotations = @quotations.closed
  end

  def new
    @quotation = Quotation.new
  end

  def create
    @quotation = Quotation.new(quotation_params)
    if @quotation.save
      redirect_to @quotation
    else
      render :new
    end
  end

  def show
    @quotation = Quotation.find(params[:id])
    @products = @quotation.products
  end

  private

  def quotation_params
    params.require(:quotation).permit(
      :name, :event_date, :company, :company, :address, :phone
    )
  end

end
