class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
    if @facade.current_video.id

    else
      flash[:error] = "Sorry, This tutorial is empty"
      redirect_to root_path
    end
  end
end
