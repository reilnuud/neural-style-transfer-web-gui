class Nst < ApplicationRecord
	mount_uploader :contentImage, ImageUploader
	mount_uploader :styleImage, ImageUploader

	validates_processing_of :contentImage
	validates_processing_of :styleImage
	validate :image_size_validation

	private
	  def image_size_validation
	    errors[:contentImage] << "should be less than 5MB" if contentImage.size > 5.25.megabytes
	    errors[:styleImage] << "should be less than 5MB" if styleImage.size > 5.25.megabytes
	end

end
