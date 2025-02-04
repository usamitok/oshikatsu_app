class DiariesController < ApplicationController
  def index
    @diaries = Diary.includes(:user).where(user_id: current_user.id)
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to diaries_path
    else
      flash.now[:danger]
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def edit
    @diary = current_user.diaries.find(params[:id])
  end

  def update
    @diary = current_user.diaries.find(params[:id])
    if @diary.update(diary_params)
        redirect_to diary_path(@diary)
    else
      flash.now[:danger]
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    diary = current_user.diaries.find(params[:id])
    diary.destroy!
    redirect_to diaries_path, status: :see_other
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :body)
  end
end