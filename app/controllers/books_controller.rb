class BooksController < ApplicationController
  before_action :authenticate_user!
  # before_action :book_owner?, only: [:edit, :update, :destroy]
  def index
    @book = Book.all.sort_by(&:title)
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.create(book_params)
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def show
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = 'Book updated'
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
