# This migration comes from oidc (originally 20220220060325)
class AddTypeToOidcKey < ActiveRecord::Migration[6.1]
  def change
    add_column :oidc_keys, :type, :string, default: 'Oidc::Key::Db'
  end
end
