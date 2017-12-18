class WelcomeController < ApplicationController
  def index
    tc = TwitterClient.new
    @message_error = ''
    @client = tc.client 

    if params[:mark_read]
      begin
        tweet = Tweet.find(params[:mark_read])
        tweet.read = 1
        tweet.save
      rescue ActiveRecord::RecordNotFound
        @message_error = 'Record Not Found'
      end
    end

    if params[:u] && params[:u] != '' 
      twitter_user_id = nil
      begin
        @timeline = @client.user_timeline(params[:u])
        @timeline.each do |t|
          _ = Tweet.find_or_create_by(
            tweet_id: t.id,
            text: t.text,
            user_id: t.user.id,
          )
          twitter_user_id = t.user.id
        end
      rescue Twitter::Error::Unauthorized
        @message_error = 'Unauthorized'
      end

      @tweets_unread = Tweet.where(user_id: twitter_user_id, read: nil)
    end
  end

  private
    def index_params
      params.require(:index).permit(:u, :mark_read)
    end
end
