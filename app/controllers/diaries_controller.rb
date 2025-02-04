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

  private

  def diary_params
    params.require(:diary).permit(:title, :body)
  end
end