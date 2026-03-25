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
    context 'when signed in as that user' do
      it 'shows the form' do
        sign_in(user)
        get edit_user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not signed in' do
      it 'redirects to root' do
        get edit_user_path(user)
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'when signes as a different user' do
      it 'redirects to root' do
        sign_in(user)
        get edit_user_path(other_user)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'update' do
    context 'when signed is as that user' do
      it 'updates that user data' do
        sign_in(user)
        patch user_path(user), params: { user: { name: 'Updated name', email_address: user.email_address } }
        expect(response).to redirect_to(edit_user_path(user))
        expect(user.reload.name).to eq('Updated name')
      end
    end

    context 'when signed in as a different user' do
      it 'redirects to root' do
        sign_in(user)
        patch user_path(other_user), params: { user: { name: 'Updated name', email_address: other_user.email_address } }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
