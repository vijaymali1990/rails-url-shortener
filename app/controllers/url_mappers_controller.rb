class UrlMappersController < ApplicationController
  before_action :set_url_mapper, only: [:show, :edit, :update, :destroy]

  # GET /url_mappers
  # GET /url_mappers.json
  def index
    @url_mappers = UrlMapper.order("search_count DESC").all
  end

  def redirect_to_original_url
    short_url_id = params['short_url_id']
    url = UrlMapper.find_by_short_url(short_url_id)

    if redirect_to "http://#{url.original_url}"
      url.search_count += 1
      url.save
    end
  end

  def short_url
    @original_url = params['original_url']
    sanitized_url = UrlMapper.sanitized_url(@original_url)

    url = UrlMapper.find_by_original_url(sanitized_url)
    new_url = false


    if url.nil?
      url = UrlMapper.generate_url(@original_url)
      new_url = true
    end
    short_url = "http://#{ENV["FQDN_#{Rails.env.upcase}_URL"]}/#{url.short_url}"

    data = {:short_url => short_url, :url => url, :new => new_url}
    render :json => data, :status => :ok
  end


  # GET /url_mappers/1
  # GET /url_mappers/1.json
  def show
  end

  # GET /url_mappers/new
  def new
    @url_mapper = UrlMapper.new
  end

  # GET /url_mappers/1/edit
  def edit
  end

  # POST /url_mappers
  # POST /url_mappers.json
  def create
    @url_mapper = UrlMapper.new(url_mapper_params)

    respond_to do |format|
      if @url_mapper.save
        format.html { redirect_to @url_mapper, notice: 'Url mapper was successfully created.' }
        format.json { render :show, status: :created, location: @url_mapper }
      else
        format.html { render :new }
        format.json { render json: @url_mapper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /url_mappers/1
  # PATCH/PUT /url_mappers/1.json
  def update
    respond_to do |format|
      if @url_mapper.update(url_mapper_params)
        format.html { redirect_to @url_mapper, notice: 'Url mapper was successfully updated.' }
        format.json { render :show, status: :ok, location: @url_mapper }
      else
        format.html { render :edit }
        format.json { render json: @url_mapper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /url_mappers/1
  # DELETE /url_mappers/1.json
  def destroy
    @url_mapper.destroy
    respond_to do |format|
      format.html { redirect_to url_mappers_url, notice: 'Url mapper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url_mapper
      @url_mapper = UrlMapper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_mapper_params
      params.fetch(:url_mapper, {})
    end
end
