class AddColumnInTopicIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :in_topic_id, :integer
    add_index :posts, [:topic_id, :in_topic_id], unique: true
  end
end
