# frozen_string_literal: true

# View helpers for tweets
module TweetsHelper
  def tweet_created_by_current_user?(user_id)
    Current.user.id == user_id
  end
end
