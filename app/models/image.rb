class Image < ApplicationRecord
	mount_uploader :image, ImageUploader

	validates_processing_of :image
	validate :image_size_validation
	 
	private
	  def image_size_validation
	    errors[:image] << "should be less than 5MB" if image.size > 5.25.megabytes
	  end

end
