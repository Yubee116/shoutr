class ShoutsController < ApplicationController
  before_action :set_shout, only: %i[show edit update destroy]

  # GET /shouts or /shouts.json
  def index
    @shouts = Shout.all
  end

  # GET /shouts/1 or /shouts/1.json
  def show; end

  # GET /shouts/new
  def new
    @shout = Shout.new
  end

  # GET /shouts/1/edit
  def edit; end

  # POST /shouts or /shouts.json
  def create
    @shout = current_user.shouts.create(shout_params)
    #
    # redirect_to root_path

    respond_to do |format|
      if @shout.save
        format.html { redirect_to root_path, notice: 'Shout was successfully created.' }
        format.json { render :show, status: :created, location: @shout }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shouts/1 or /shouts/1.json
  def update
    respond_to do |format|
      if @shout.update(shout_params)
        format.html { redirect_to shout_url(@shout), notice: 'Shout was successfully updated.' }
        format.json { render :show, status: :ok, location: @shout }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shouts/1 or /shouts/1.json
  def destroy
    @shout.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Shout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_shout
    @shout = Shout.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shout_params
    params.require(:shout).permit(:body, :user_id)
  end
end
