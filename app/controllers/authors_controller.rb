class AuthorsController < ApplicationController
  
  before_filter :find_author, only: [:show, :edit, :update, :destroy, :add_book]
  
  def index
    @authors = Author.all
  end
  
  def show
    if @author = Author.where(id: params[:id]).first
      render "authors/show"
    else
      render text: "404: Page not found", status: 404
    end
  end
  
  def new
    @author = Author.new
    render "authors/new"
  end

  def edit 
    @books=Book.all
  end 
  
  def create 
    author_params = params.require(:author).permit(:name)
    @author = Author.create(author_params)
    if @author.errors.empty?
      redirect_to author_path(@author)
    else 
      render "new"
    end
  end
  
  def update 
    author_params = params.require(:author).permit(:name)
    @author.update_attributes(author_params)
    if @author.errors.empty?
      redirect_to author_path(@author)
    else 
      render "edit"
    end
  end
  
  def destroy
    @author
    @author.destroy
    redirect_to action: "index"
  end
  
  def add_book
    @book = Book.find(params[:book_id])
    @author.books<<@book
    render "authors/show"
  end  
  
  private
    
    def find_author
       @author = Author.find(params[:id]) 
    end
  
end
