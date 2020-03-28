require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  # initialize test data
  let!(:posts) { create_list(:post, 10) }
  let(:post_id) { posts.first.id }

  # Test suite for GET /posts
  describe 'GET /api/v1/posts' do
    # make HTTP get request before each example
    before { get '/api/v1/posts' }

    it 'returns posts' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /posts/:id
  describe 'GET /api/v1/posts/:id' do
    before { get "/api/v1/posts/#{post_id}" }

    context 'when the record exists' do
      it 'returns the post' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(post_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:post_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test suite for POST /posts
  describe 'POST /api/v1/posts' do
    let(:valid_attributes) { { content: 'Learn Elm' } }
    let(:headers) { {auth_token: login} }

    context 'when not logged in user' do
      before { post '/api/v1/posts', params: valid_attributes }

      it 'creates a post' do
        expect(response).to have_http_status(401)
      end
    end

    context 'with valid parameters' do
      before { post '/api/v1/posts', params: valid_attributes, headers: headers }

      it 'creates a post' do
        expect(json['content']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid parameters' do
      before { post '/api/v1/posts', params: { }, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  # Test suite for PUT /posts/:id
  describe 'PUT /api/v1/posts/:id' do
    let(:valid_attributes) { { content: 'Shopping' } }
    let(:headers) { {auth_token: login} }

    context 'when not logged in user' do
      before { put "/api/v1/posts/#{post_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when logged in user' do
      before { put "/api/v1/posts/#{post_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /posts/:id
  describe 'DELETE /api/v1/posts/:id' do
    let(:headers) { {auth_token: login} }

    context 'when not logged in user' do
      before { delete "/api/v1/posts/#{post_id}" }

      it 'delete a post' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when logged in user' do
      before { delete "/api/v1/posts/#{post_id}", headers: headers }

      it 'delete a post' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
