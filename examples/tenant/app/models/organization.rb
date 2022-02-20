class Organization < ApplicationRecord
	belongs_to :keyset, class_name: "Oidc::Keyset", dependent: :destroy, optional: true

	def to_param
		slug
	end

end
