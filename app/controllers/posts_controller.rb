class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  # GET /posts or /posts.json
  def index
    @user = User.find(params[:user_id])
    @posts = Post.show_posts(@user)
  end

  # GET /posts/1 or /posts/1.json
  def show
    set_post
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    set_post
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)
    @user = User.find(params[:user_id])

    if current_user == @user
      respond_to do |format|
        if @post.save
          format.turbo_stream
          # format.html { redirect_to user_posts_path(current_user), notice: "Post was successfully created." }
          # format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          # format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:alert] = 'You are not authorized to do that'
      redirect_to root_path
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @user = User.find(params[:user_id])
    @posts = Post.show_posts(@user)

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        # format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      # format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
