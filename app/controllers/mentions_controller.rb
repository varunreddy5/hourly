class MentionsController < ApplicationController
  def index
    @mentions = User.all
    respond_to do |format|
      format.json
    end
  end
end