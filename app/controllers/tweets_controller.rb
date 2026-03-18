class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy]
  def index
    @tweets = Tweet.all
  end

  def show; end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
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
