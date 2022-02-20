class Organization < ApplicationRecord
	has_many :clusters

	def to_param
		slug
	end

end
