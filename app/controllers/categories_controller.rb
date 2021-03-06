class CategoriesController < ApplicationController
  before_filter :correct_user_type,   only: :index
  before_filter :admin_user, only: [:edit, :update, :destroy]

  def index
    @user = current_user
    @categories = Category.all
    @student = Student.find(params[:user_id])
    @current_quarter = determine_academic_quarter
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      render :index
    else
      render :new
      flash[:danger] = "Error in creating category"
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
  end

  def destroy
  end

  def report_card
    @categories = Category.all
  end


  private
    # Before filters
    def correct_user_type
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user) || current_user.type == 'Teacher'
      unless current_user?(@user) || current_user.type == 'Teacher'
        flash[:danger] = "You do not have access to view other students' report cards"
      end
    end

end


