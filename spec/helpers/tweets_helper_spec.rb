# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TweetsHelper. For example:
#
# describe TweetsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TweetsHelper, type: :helper do
  describe '#tweet_created_by_current_user?' do
    let(:current_user) do
      User.create!(
        email_address: 'current@example.com',
        password: 'password123',
        name: 'Current'
      )
    end
    let(:session) { Session.create!(user: current_user) }
    around do |example|
      Current.session = session
      example.run
    ensure
      Current.reset
    end
    it 'returns true when user_id matches the current user' do
      expect(helper.tweet_created_by_current_user?(current_user.id)).to be true
    end
    it 'returns false when user_id does not match the current user' do
      other = User.create!(
        email_address: 'other@example.com',
        password: 'password123',
        name: 'Other'
      )
      expect(helper.tweet_created_by_current_user?(other.id)).to be false
    end
  end
end
