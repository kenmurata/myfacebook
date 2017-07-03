class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.timestamps null: false
      t.string :title
      t.text :content
    end
  end
end
