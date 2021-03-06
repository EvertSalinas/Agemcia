class QuotationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pending_quotations   = Quotation.pendiente.order(:id)
    @completed_quotations = Quotation.completada.order(:id)
    @cancelled_quotations = Quotation.cancelada.order(:id)
  end

  def new
    @quotation = Quotation.new
  end

  def create
    @quotation  = Quotation.new(quotation_params)
    if @quotation.save
      redirect_to @quotation
    else
      flash[:error] = @quotation.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @quotation  = Quotation.find(params[:id])
    @products   = @quotation.products
  end

  def edit
    @quotation  = Quotation.find(params[:id])
  end

  def update
    @quotation  = Quotation.find params[:id]
    if @quotation.update quotation_params
      redirect_to @quotation
    else
      flash[:error] = @quotation.errors.full_messages.to_sentence
      render :edit
    end
  end

  def download
    @quotation = Quotation.find(params[:id])
    file_name = "Cotización-#{params[:id]}.pdf"
    build_pdf
    send_data @pdf.render, filename: file_name
  end

  def complete
    @quotation = Quotation.find params[:id]
    if @quotation.completar!
      redirect_to @quotation
    else
      flash[:error] = @quotation.errors.full_messages.to_sentence
      render :show
    end
  end

  def reactivate
    @quotation = Quotation.find params[:id]
    if @quotation.reactivar!
      redirect_to @quotation
    else
      render :show
    end
  end

  def cancel
    @quotation = Quotation.find params[:id]
    if @quotation.cancelar!
      redirect_to @quotation
    else
      flash[:error] = @quotation.errors.full_messages.to_sentence
      render :show
    end
  end

  def pay
    @quotation = Quotation.find params[:id]
    if @quotation.update(paid: 'si')
      redirect_to @quotation
    else
      flash[:error] = @quotation.errors.full_messages.to_sentence
      render :show
    end
  end

  private

  def build_pdf
    @pdf = Quotation::QuotationPdf.new(@quotation, params)
  end

  def quotation_params
    params.require(:quotation).permit(
      :name, :company, :company, :address, :phone, :elaboration_date, :with_iva,
      :event_date, :event_time, :pickup_date, :pickup_time, :deliver_date, :deliver_time
    )
  end

end
