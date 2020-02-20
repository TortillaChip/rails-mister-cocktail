class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    @ingredients = Ingredient.all
  end

  def create
    @dose = Dose.new(dose_description)
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.cocktail = @cocktail
    @dose.ingredient = Ingredient.find(dose_ingredient[:ingredient])
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy

    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def dose_description
    params.require(:dose).permit(:description)
  end

  def dose_ingredient
    params.require(:dose).permit(:ingredient)
  end
end
