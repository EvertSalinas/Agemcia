class ProductsController < ApplicationController

  def new
    @quotation      = Quotation.find(params[:quotation_id])
    @quotation_id   = @quotation.id
    @product        = Product.new
  end

  def create
    @quotation   = Quotation.find(params[:product][:quotation_id])
    @product     = @quotation.products.build(product_params)
    if @product.save
      redirect_to @quotation
    else
      flash[:error] = @product.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])
    @quotation = Quotation.find(@product.quotation_id)
    if @product.update(product_update_params)
      update_flash_message
    else
      flash[:error] = @product.errors.full_messages.to_sentence
    end
    redirect_to @quotation
  end

  def destroy
    @product = Product.find(params[:id])
    @quotation = Quotation.find(@product.quotation_id)
    if @product.destroy
      redirect_to @quotation
    end
  end

  private

  def update_flash_message
    flash[:success] = "El producto ha sido actualizado."
  end

  def product_params
     params.require(:product).permit(:amount, :concept, :price, :quotation_id)
  end

  def product_update_params
    params.require(:product).permit(:amount, :price)
  end

end
