class ProductsController < ApplicationController
	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def show
		@product = Product.find(product_id)
	end

	def edit
		@product = Product.find(product_id)
		render :new
	end

	def create
		product_params = params.require(:product).permit(:title, :description, :price)

		@product = Product.new(product_params)

		if @product.save
			redirect_to products_url	
		else
			render :new
		end
		
	end

	def update

		@product = Product.find(product_id)

		if @product.update(product_params)
			flash[:notice] = 'You have updated product successfully'
			redirect_to products_url	
		else
			flash.now[:notice] = 'You have updated product failure'
			render :new
		end
	
	end

	def destroy
		@product = Product.find(product_id)

		if @product.destroy
			flash[:notice] = 'You have deleted product successfully'
		else
			flash.now[:notice] = 'You have deleted product failure'
		end

		redirect_to products_url	
		
	end

	private

	def product_id
		params.require(:id)
	end

	def product_params
		params.require(:product).permit(:title, :description, :price)
	end
end