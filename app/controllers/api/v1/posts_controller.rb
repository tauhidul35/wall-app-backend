class Api::V1::PostsController < Api::ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /api/v1/posts
  def index
    posts = Post.all.map{|post| post.slice(:id, :content, :created_at).merge!(own_post: @current_api_user == post.user)}
    success_response({posts: posts})
  end

  # POST /api/v1/posts
  def create
    post = @current_api_user.posts.create(post_params)

    if post.errors.present?
      error_response(post.errors.full_messages.join('. '))
    else
      success_response({post: post.slice(:id, :content)}, :created)
    end
  end

  # GET /api/v1/posts/:id
  def show
    success_response(post: @post.slice(:id, :content, :created_at)
                                .merge!(own_post: @current_api_user == @post.user))
  end

  # PUT /api/v1/posts/:id
  def update
    if @post.user == @current_api_user
      @post.update(post_params)

      if @post.errors.present?
        error_response(@post.errors.full_messages.join('. '))
      else
        success_response({
                             post: @post.slice(:id, :content, :created_at).merge!(own_post: true),
                             message: 'Updated successfully'
                         }, :accepted)
      end
    else
      error_response('Unauthorized request', :unauthorized)
    end
  end

  # DELETE /api/v1/posts/:id
  def destroy
    if @post.user == @current_api_user
      @post.destroy

      if @post.errors.present?
        error_response(@post.errors.full_messages.join('. '))
      else
        success_response({
                             post: @post.slice(:id, :content, :created_at).merge!(own_post: true),
                             message: 'Delete successfully'
                         }, :accepted)
      end
    else
      error_response('Unauthorized request', :unauthorized)
    end
  end

  private

  def post_params
    # whitelist params
    params.permit(:content)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
    raise ActiveRecord::RecordNotFound.new('Requested post not available') unless @post
  end
end
