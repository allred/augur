class CreateTableTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :text 
      t.string :tweet_id
      t.string :user_id
      t.boolean :read

      t.timestamps

      t.index :tweet_id
      t.index :user_id
    end
  end
end
