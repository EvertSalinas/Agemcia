class QuotationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quotations

  def index
    @pending_quotations = @quotations.pending
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

  def edit
    @quotation = Quotation.find(params[:id])
  end

  def update
    @quotation = Quotation.find params[:id]
    if @quotation.update quotation_params
      redirect_to @quotation
    else
      render :edit
    end
  end

  def destroy
    @quotation = Quotation.find(params[:id])
    if @quotation.destroy
      redirect_to quotations_path
    end
  end

  # def cancel_quotation
  #   if @quotation.status == 'pendiente'
  #     @quotation.status = 'cancelada'
  #     render @quotation
  #   else
  #     render @quotation
  #   end
  # end

  private

  def quotation_params
    params.require(:quotation).permit(
      :name, :event_date, :company, :company, :address, :phone
    )
  end

end
