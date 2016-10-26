class AddPrivateStatusToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :private, :boolean
  end
end
