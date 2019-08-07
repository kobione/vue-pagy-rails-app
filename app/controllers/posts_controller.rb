class PostsController < ApplicationController
  include Pagy::Backend

  rescue_from Pagy::VariableError, with: :redirect_to_first_page
  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index

    @pagy, @posts = pagy(Post.cleaner)

    paginationObj = {
      page: @pagy.page,
      prev: @pagy.prev,
      next: @pagy.next,
      last: @pagy.last,      
    }

    render :json => { postsArr: @posts, pagyData: paginationObj }
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    render :json => @post
  end

  # GET /posts/new
  def new
    @post = Post.new
    render :json => @post
  end

  # GET /posts/1/edit
  def edit
    render :json => @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.json { render :show, status: :created, location: @post }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.json { render :show, status: :ok, location: @post }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.cleaner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.fetch(:post, {})
    end

    def redirect_to_first_page(exception)
      redirect_to url_for(page: 1), notice: "Page ##{params[:page]} is overflowing. Showing page 1 instead."
    end

    def redirect_to_last_page(exception)
      redirect_to url_for(page: exception.pagy.last), notice: "Page ##{params[:page]} is overflowing. Showing page #{exception.pagy.last} instead."
    end
end
