class CreateOidcKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :oidc_keys do |t|
      t.integer :keyset_id
      t.text :private_key
      t.text :public_key

      t.timestamps
    end
  end
end
