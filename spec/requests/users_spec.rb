# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) do
    User.create!(
      email_address: 'user@test.com',
      password: 'test123',
      name: 'John'
    )
  end
  let(:other_user) do
    User.create!(
      email_address: 'other@test.com',
      password: 'test456',
      name: 'Jane'
    )
  end

  def sign_in(user)
    post session_path, params: { email_address: user.email_address, password: user.password }
  end

  describe 'edit' do
    it 'shows the form when signed in as that user' do
      sign_in(user)
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'does not show another users form' do
      sign_in(user)
      get edit_user_path(other_user)
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'update' do
    it 'updates when signed is as that user' do
      sign_in(user)
      patch user_path(user), params: { user: { name: 'Updated name', email_address: user.email_address } }
      expect(response).to redirect_to(edit_user_path(user))
      expect(user.reload.name).to eq('Updated name')
    end
  end
end
