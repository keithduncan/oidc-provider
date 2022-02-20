class AddTypeToOidcKey < ActiveRecord::Migration[6.1]
  def change
    add_column :oidc_keys, :type, :string, default: 'Oidc::Key::Db'
  end
end
