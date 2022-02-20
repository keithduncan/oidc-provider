class CreateClusters < ActiveRecord::Migration[6.1]
  def change
    create_table :clusters do |t|
      t.string :name, limit: 30
      t.references :organization, null: false, foreign_key: true
      t.references :keyset

      t.timestamps
    end

    remove_column :organizations, :keyset_id, :integer
  end
end
