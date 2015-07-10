require "rails_helper"

RSpec.describe Product, :type => :model do
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:description) }
	it { should validate_numericality_of(:price).is_greater_than(0) }
	
	it 'title is shorter than description' do
		product = Product.create(title: 'ruby book', description: 'ruby')
		product.validate
		expect(product.errors.messages).to include(title: ["title is shorter than description"] )
	end

	it 'title is lowcase' do
		product = Product.create(title: "RUBY LEARN")
		product.validate
		expect(product.title).to eq 'ruby learn'
	end


end