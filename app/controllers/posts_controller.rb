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
    set_user

    if current_user == @user
      @post = Post.new
    else
      flash[:alert] = 'You are not authorized to do that action'
      redirect_to root_path
    end
  end

  # GET /posts/1/edit
  def edit
    set_user

    if current_user == @user
      set_post
    else
      flash[:alert] = 'You are not authorized to do that action'
      redirect_to root_path
    end
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)
    set_user

    if current_user == @user
      respond_to do |format|
        if @post.save
          format.turbo_stream { render turbo_stream: turbo_stream.prepend('posts', @post)}
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
    set_user
    set_post

    respond_to do |format|
      if @post.update(post_params)
        format.turbo_stream { render turbo_stream: turbo_stream.update('posts', @post) }
        # format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        # format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    set_post

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

  def set_user
    @user = User.find(params[:user_id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content)
  end

end
