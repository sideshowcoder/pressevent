class CreateWordpressInstances < ActiveRecord::Migration
  def change
    create_table :wordpress_instances do |t|
      t.column :name, :string
      t.column :url, :string
      t.column :api_key, :string
      t.column :auto_checking, :boolean
      t.references :user
      t.timestamps
    end
  end
end
