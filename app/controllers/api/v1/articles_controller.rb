class Api::V1::ArticlesController < ApplicationController
  # List all the article present
  def index
    article = Article.all
    render json: article, status: 200
  end

  #List the particular article with id
  def show
    article = Article.find_by(id: params[:id])
    if article
      render json: article, status: 200
    else
      render json: {
        error: "Error while finding article"
      }
    end
  end

  #Create a new article
  def create
    article = Article.new(
      title: arti_params[:title],
      body: arti_params[:body],
      author: arti_params[:author],
    )
    
    if article.save
      render json: article, status: 200
    else
      render json: {
        error: "Error while creating.." 
      }
    end
  end

  #Update the existing article
  def update
    article = Article.find_by(id: params[:id])
    if article
      article = Article.update(title: params[:title], body: params[:body], author: params[:author])
      render json: "Update successfully", status: 200
    else
      render json: "Can't be updated, Record Not found!!"
    end
  end

  #Destroy the article
  def destroy
    article = Article.find_by(id: params[:id])
    if article
      article.destroy
      render json: "Article deleted"
    else
      render json: "Not Found"
    end
  end

  private
  #params required 
  def arti_params
    params.require(:article).permit([
      :title,
      :body,
      :author
    ])
  end

end
