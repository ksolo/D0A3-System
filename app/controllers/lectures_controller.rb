# encoding: UTF-8
class LecturesController < ApplicationController


	def create
		@group = Group.find(params[:group_id])
		@lecture = @group.lectures.build(lecture_params)
		if @group.save  
		    flash[:success] = "Clase creada exitosamente"
		    redirect_to @group
	    else
	      render 'new'
	    end
	end

	def new
	   @group = Group.find(params[:group_id])
	   @lecture = @group.lectures.build
	end

	def edit
		@group = Group.find(params[:group_id])
		@lecture = @group.lectures.find(params[:id])
	end

	def show
		@lecture = Lecture.find(params[:id])
		@group = Group.find(params[:group_id])
	end

	def update
		@group = Group.find(params[:group_id])
		@lecture = Lecture.find(params[:id])
	    if @lecture.update_attributes(lecture_params)
	    	flash[:success] = "Actualización Exitosa"
	    	redirect_to @group
	    else
	    	render 'edit'
	    end
	end

	def destroy
		@group = Group.find(params[:group_id])
		Lecture.find(params[:id]).destroy
    	flash[:success] = "Clase borrada"
    	redirect_to @group
	end

	private

	def lecture_params
      params.require(:lecture).permit( :date, :group_id, :observation )
    end

end