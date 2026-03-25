# frozen_string_literal: true

#
# Application user account with authentication and authored tweets.
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :tweets

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, :name, presence: { message: 'must be given please' }
  validates :email_address, uniqueness: { message: 'is already in use' }
end
