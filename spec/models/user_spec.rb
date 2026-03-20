require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email_address: 'test@test.com', password: 'test123', name: 'John') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a email_address' do
    subject.email_address = nil
    expect(subject).to_not be_valid
  end

  it('is not valid without a name') do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'rejects a duplicate email_address' do
    subject.save!
    dup_user = subject.dup
    expect(dup_user).not_to be_valid
    expect(dup_user.errors[:email_address]).to include('is already in use')
  end
end
