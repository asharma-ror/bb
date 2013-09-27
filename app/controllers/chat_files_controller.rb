class ChatFilesController < ApplicationController

  before_filter :authenticate_user!
  layout false

  def create
    @chat_file = ChatFile.new(params[:chat_file])
    respond_to do |format|
      if @chat_file.save
        format.js
        format.html { redirect_to @chat_file, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        @error = "Something went wrong, Please try again or talk to support"
        format.js
        format.html { render action: "edit" }
        format.json { render json: @chat_file.errors, status: :unprocessable_entity }
      end
    end
  end

end
