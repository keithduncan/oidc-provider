# This migration comes from oidc (originally 20211205050520)
class AddKidToOidcKey < ActiveRecord::Migration[6.1]
  def change
    add_column :oidc_keys, :kid, :string
  end
end
