class SettingsController < ApplicationController
 
  def update
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.js { render layout: false }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
