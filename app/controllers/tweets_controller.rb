class TweetsController < ApplicationController

    get '/tweets' do  
        if logged_in?
            @tweets = Tweet.all 
            @user = current_user
            erb :'tweets/index'
        else 
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
          @user = current_user
          erb :'tweets/create_tweet'
        else
          redirect "/login"
        end
      end

    post '/tweets' do 
        if empty_tweet? 
            redirect "/tweets/new"    
        elsif logged_in? && !empty_tweet?
            @tweet = current_user.tweets.build(content: params[:content])
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        else 
            redirect '/login'
        end

    end
    
    get '/tweets/:id' do 
        if logged_in? 
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else 
            redirect "/login"
        end 
    end

    get '/tweets/:id/edit' do 
        @tweet = Tweet.find(params[:id])
        if logged_in? && @tweet.user == current_user
            erb :'tweets/edit_tweet'
        else
            redirect "/login"
        end
    end

    patch '/tweets/:id' do 
        @user = current_user
        @tweet = Tweet.find(params[:id])

        if empty_tweet?
            redirect "/tweets/#{@tweet.id}/edit"
        else 
            @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
        end 
    end 

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        
        if @tweet.user == current_user
            @tweet.delete 
            redirect '/tweets'
        # else 
        #     redirect "/login"
        end
      end

end
