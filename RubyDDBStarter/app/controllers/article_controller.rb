class ArticleController < ApplicationController


  def get
    @articleId=params.fetch(:articleId).to_i
    @article = Article.getSingleItem(@articleId)
    puts "Got article: "+@article.inspect


  end


end
