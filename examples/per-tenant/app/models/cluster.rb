class Cluster < ApplicationRecord
  belongs_to :organization
  belongs_to :keyset, class_name: "Oidc::Keyset", dependent: :destroy, optional: true

  def to_param
    name
  end

end
