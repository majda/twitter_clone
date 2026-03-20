# frozen_string_literal: true

#
# Handles listing, creating, updating, and deleting tweets.
class TweetsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :set_tweet, only: %i[show edit update destroy]
  def index
    # @tweets = Tweet.all
    @tweets = Tweet.includes(:user).order(created_at: :desc)
  end

  def show; end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Current.user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to @tweet
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.expect(tweet: [:body])
  end
end
