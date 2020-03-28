class Api::V1::PostsController < Api::ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /api/v1/posts
  def index
    posts = Post.all.map do |post|
      { id: post.id, content: post.content }
    end

    json_response posts
  end

  # POST /api/v1/posts
  def create
    post = Post.create!(post_params)
    json_response(post, :created)
  end

  # GET /api/v1/posts/:id
  def show
    json_response(@post)
  end

  # PUT /api/v1/posts/:id
  def update
    @post.update(post_params)
    head :no_content
  end

  # DELETE /api/v1/posts/:id
  def destroy
    @post.destroy
    head :no_content
  end

  private

  def post_params
    # whitelist params
    params.permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
