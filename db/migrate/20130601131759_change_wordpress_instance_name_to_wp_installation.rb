class ChangeWordpressInstanceNameToWPInstallation < ActiveRecord::Migration
  def change
    rename_table :wordpress_instances, :wp_installations
  end
end
