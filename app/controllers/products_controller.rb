class ProductsController < ApplicationController

  def new
    @quotation = Quotation.find(params[:quotation_id])
    @product = Product.new
  end

  def create
    @quotation = Quotation.find(params[:quotation_id])
    @product = @quotation.products.build(product_params)
    if @product.save
      redirect_to @quotation
    else
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to quotation_path
    end
  end

  private

  def product_params
     params.require(:product).permit(:amount, :concept, :price, :quotation_id)
  end
end
