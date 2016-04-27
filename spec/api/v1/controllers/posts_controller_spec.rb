require 'rails_helper'
include SessionsHelper

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:my_user){ create(:user) }
  let(:my_topic){ create(:topic) }
  let(:my_post){ create(:post) }
  let(:new_att){ Post.create!(title: "New Title", body: "New Body for this Post", topic: my_topic, user: my_user)}

  before do
    create_session(my_user)
  end
  describe "PUT update" do

    before { put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_att.title, body: new_att.body} }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns json content type" do
      expect(response.content_type).to eq('application/json')
    end

    it "updates a topic with the correct attributes" do
      updated_post = Post.find(my_post.id)
      expect(response.body).to eq(updated_post.to_json)
    end
  end

  describe "POST create" do
    before { new_post = post :create, topic_id: my_topic.id, post: {title: new_att.title, body: new_att.body} }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns json content type" do
      expect(response.content_type).to eq 'application/json'
    end

    it "creates a post with the correct attributes" do
      hashed_json = JSON.parse(response.body)
      expect(hashed_json["title"]).to eq(new_att.title)
      expect(hashed_json["body"]).to eq(new_att.body)
    end
  end

  describe "DELETE destroy" do
    before { delete :destroy, id: my_post.id }

# #18
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns json content type" do
      expect(response.content_type).to eq 'application/json'
    end

    it "returns the correct json success message" do
      expect(response.body).to eq({ message: "Post destroyed", status: 200 }.to_json)
    end

    it "deletes my_topic" do
      expect{ Post.find(my_post.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
