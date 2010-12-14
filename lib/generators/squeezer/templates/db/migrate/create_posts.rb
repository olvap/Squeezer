class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :comment_id
      t.text :body
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
