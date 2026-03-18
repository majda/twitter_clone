# frozen_string_literal: true

class Tweet < ApplicationRecord
  validates :body, presence: true
end
