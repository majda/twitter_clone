class AddUrlToTweets < ActiveRecord::Migration[8.1]
  def change
    add_column(:tweets, :url, :string)
  end
end
