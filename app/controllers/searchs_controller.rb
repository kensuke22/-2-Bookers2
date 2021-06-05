class SearchsController < ApplicationController

  def search
      method = params[:search_method]
      word = params[:search_word]
      @posts = User.search(method,word)
  end

end
