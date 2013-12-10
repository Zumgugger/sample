class Change < ActiveRecord::Migration
  def change
    change_column :relationships, :followed_id, :integer
  end
end
