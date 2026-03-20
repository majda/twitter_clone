# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let(:user) do
    User.create!(
      email_address: 'author@example.com',
      password: 'password123',
      name: 'Author'
    )
  end

  subject { Tweet.new(body: 'This my first tweet', user: user) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a body' do
    subject.body = nil
    expect(subject).to_not be_valid
  end
end
