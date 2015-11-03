class ArticleController < ApplicationController


  def get
    @articleId=params.fetch(:articleId).to_i
    @article = getSingleItem(@articleId)
    puts "Got article: "+@article.inspect

  end

  def getSingleItem(id)
    return Article.new(Aws::DynamoDB::Client.new.get_item(Article.byId(id)).item)
  end

end
