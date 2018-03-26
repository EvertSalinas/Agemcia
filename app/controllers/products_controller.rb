class ProductsController < ApplicationController
  before_action :set_current_quotation

  def new
    @product = Product.new
  end

  def create
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
     params.require(:product).permit(:amount, :concept, :price)
  end
end
