class NstsController < ApplicationController
  before_action :set_nst, only: [ :show, :edit, :update, :destroy]

  # GET /nsts
  # GET /nsts.json
  def index
    @nsts = Nst.all
  end

  # GET /nsts/1
  # GET /nsts/1.json
  def show
  end

  # GET /nsts/new
  def new
    @nst = Nst.new
  end

  # GET /nsts/1/edit
  def edit
  end

  # POST /nsts
  # POST /nsts.json
  def create
    @nst = Nst.new(nst_params)
    respond_to do |format|
      format.html { redirect_to action: :index }
      @styleSize = @nst.styleRatio * @nst.imageSize
      if @nst.save
        @nstexec = "(cd ~/fast-neural-style/ && exec th slow_neural_style.lua \
          -content_image      #{Rails.root.to_s}/public#{@nst.contentImage} \
          -style_image        #{Rails.root.to_s}/public#{@nst.styleImage} \
          -image_size         #{@nst.imageSize} \
          -content_weights    #{@nst.contentWeight} \
          -style_weights      #{@nst.styleWeight} \
          -num_iterations     #{@nst.iterations} \
          -style_image_size   #{@styleSize} \
          -output_image       #{Rails.root.to_s}/public/nst-output/nst-#{@nst.id}.jpg \
          -print_every        1 \
          -save_every         100 \
          -gpu                0 \
          -backend            cuda\
          -use_cudnn          1 \
          -tv_strength        #{1/(@nst.tvRatio * 10) } \
          -learning_rate      #{@nst.learnRate} \
          )"
        SlowStyleTransferJob.perform_later @nstexec, @nst
        @nst.update(status: "queued")
        # format.json { render :show, status: :created, location: @nst }
      else
        format.html { render :new }
        format.json { render json: @nst.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nsts/1
  # PATCH/PUT /nsts/1.json
  def update
    respond_to do |format|
      if @nst.update(nst_params)
        format.html { redirect_to @nst, notice: 'nst was successfully updated.' }
        format.json { render :show, status: :ok, location: @nst }
      else
        format.html { render :edit }
        format.json { render json: @nst.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nsts/1
  # DELETE /nsts/1.json
  def destroy
    @nst.destroy
    respond_to do |format|
      format.html { redirect_to nsts_url, notice: 'nst was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nst
      @nst = Nst.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nst_params
      params.require(:nst).permit(:styleImage, :styleWeight, :contentImage, :contentWeight, :styleRatio, :imageSize, :originalColors, :initPattern, :pooling, :iterations, :outputImage, :learnRate, :tvRatio, :status )
    end
end
