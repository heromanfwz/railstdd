class Product < ActiveRecord::Base
	validates :title, :description,  presence: true
	validates :price, numericality: { greater_than: 0 }
	validate :title_is_shorter_than_description
	validate :title_downcase

	def title_is_shorter_than_description
		return if title.blank? or description.blank?
		if title.length > description.length
			errors.add(:title, "title is shorter than description")
		end
	end

	def title_downcase
		return if self.title.blank?
		self.title = self.title.downcase
	end

end