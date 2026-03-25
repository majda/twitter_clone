namespace :tweets do
  task add_urls: :environment do
    Tweet.all.each do |tweet|
      tweet.update!(url: 'example.com')
    end
  end
end
