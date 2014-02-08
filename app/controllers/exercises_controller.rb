# encoding: UTF-8
class ExercisesController < ApplicationController

	def index
		@exercises = Exercise.all
	end

	def new
		@exercise = Exercise.new
	end

	def create
		@exercise = Exercise.new(exercise_params)
		if(@exercise.save)
			flash[:succes] = 'Ejercicio creado exitosamente'
			redirect_to exercises_path
		else
			render 'new'
		end
	end

	def edit
		@exercise = Exercise.find(params[:id])
	end

	def show
		@exercise = Exercise.find(params[:id])
	end

	def update
		@exercise = Exercise.find(params[:id])
		if @exercise.update_attributes(exercise_params)
			redirect_to exercises_path
			flash[:succes] ="Actualización exitosa"
		else
			@exercise.reload
			render 'edit'
		end
	end

	def destroy
		Exercise.find(params[:id]).destroy
		flash[:succes] = "Ejercicio borrado"
		redirect_to exercises_path
	end 

	private

	def exercise_params
		params.require(:exercise).permit(:area , :min_age , :max_age , :objective , :description , :material , :music , :lectures , :plans)
    end

end