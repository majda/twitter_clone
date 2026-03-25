# frozen_string_literal: true

#
# A short post authored by a user.
class Tweet < ApplicationRecord
  belongs_to :user

  validates :body, presence: true
  validates :url, presence: true
end
