require "rails_helper"

RSpec.describe ProductsController, type: :controller do

	describe '#index' do
		let!(:products){ FactoryGirl.create_list(:product, 2) }

		it 'Products Listing' do
			get :index
			expect(assigns(:products).size).to eq 2
		end
	end

	describe '#new' do
		it 'new a product' do
			get :new
			expect(assigns(:product)).to be_a Product
		end
	end

	describe '#show' do
		let!(:product){ FactoryGirl.create(:product) }

		def do_request
			get :show, id: product.id
		end

		it 'Show Product by Id' do
			do_request
			expect(assigns(:product).id).to eq product.id
		end
	end

	describe '#edit' do
		let!(:product) { FactoryGirl.create(:product) }

		def do_request
			get :edit, id: product.id
		end

		it 'Edit a product' do
			do_request
			expect(assigns(:product).title).to eq product.title
			expect(response).to render_template :new
		end
	end

	describe '#create' do
	 	let(:params){ FactoryGirl.attributes_for(:product) }
	 	def do_request
	 		post :create, product: params
	 	end
	 	
	 	context 'successfully' do
		 	it 'Create a product successfully' do
		 		expect{ do_request }.to change(Product, :count).by(1)
		 		expect(response).to redirect_to products_url
		 	end
	 	end

	 	context 'fail' do
	 		let(:params){ FactoryGirl.attributes_for(:product, title: " ") }
	 			
	 		it 'Create a product fail' do
	 			expect{ do_request }.not_to change(Product, :count)
	 			expect(response).to render_template :new
	 		end
	 	end
  end

  describe '#update' do
  	let!(:product){ FactoryGirl.create(:product) }
  	def do_request
  		patch :update, id: product.id, product: params
  	end

  	context 'successfully' do
	  	let(:params){ FactoryGirl.attributes_for(:product, title: "joomla book") }

	  	it 'Update product successfully' do
	  		do_request
	  		expect(assigns(:product).title).to eq params[:title]
	  		expect(response).to redirect_to products_url
	  	end
  	end

  	context 'failure' do
	  	let(:params){ FactoryGirl.attributes_for(:product, title: " ") }

	  	it 'Update product fail' do
	  		do_request
	  		expect(assigns(:product).reload.title).not_to eq params[:title] 
	  		expect(response).to render_template :new
	  	end
  	end
  end

  describe '#destroy' do
  	let!(:product){ FactoryGirl.create(:product) }
  	def do_request
  		delete :destroy, id: product.id
  	end

  	context 'successfully' do
  		it 'Delete product successfully' do
  			expect{ do_request }.to change(Product, :count).by(-1)	
  			expect(response).to redirect_to products_url
  		end
  	end
  
  end

end