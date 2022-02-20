class CreateOidcKeysets < ActiveRecord::Migration[6.1]
  def change
    create_table :oidc_keysets do |t|

      t.timestamps
    end
  end
end
