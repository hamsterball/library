class BooksController < ApplicationController

  before_filter :find_book, only: [:show, :edit, :update, :destroy, :add_author]
  
  def index
    @books = Book.all
  end
  
  def show
    if @book = Book.where(id: params[:id]).first
      render "books/show"
    else
      render text: "404: Page not found", status: 404
    end
  end
  
  def new
    @book = Book.new
  end

  def edit 
  end 
  
  def create 
    book_params = params.require(:book).permit(:name)
    @book = Book.create(book_params)
    if @book.errors.empty?
      redirect_to book_path(@book)
    else 
      render "new"
    end
  end
  
  def update 
    book_params = params.require(:book).permit(:name)
    @book.update_attributes(book_params)
    if @book.errors.empty?
      redirect_to book_path(@author)
    else 
      render "edit"
    end
  
  end
  
  def destroy
  
    @book
    @book.destroy
    redirect_to action: "index"
  end
  
  def add_author
    @author = Author.find(params[:author_id])
    @book.authors<<@author
    render "books/show"
  end  
  
  private
    
    def find_book
       @book = Book.find(params[:id]) 
    end
  


end
