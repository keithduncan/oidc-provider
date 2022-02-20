class AddKeysetIdToOrganization < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :keyset_id, :integer
  end
end
