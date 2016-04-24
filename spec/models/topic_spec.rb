require 'rails_helper'

RSpec.describe Topic, type: :model do
 let(:topic) { create(:topic) }

 it { is_expected.to have_many(:posts) }
 it { is_expected.to have_many(:labelings) }
 # #10
 it { is_expected.to have_many(:labels).through(:labelings) }
# #1
 describe "attributes" do
   it "has name, description, and public attributes" do
     expect(topic).to have_attributes(name: topic.name, description: topic.description)
   end

# #2
   it "is public by default" do
     expect(topic.public).to be(true)
   end
 end

 describe "scope" do
   before do
     @public_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
     @private_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: false)
   end

   describe "visible to user" do
     it "returns all topics if the user is present" do
       user = User.new
       expect(Topic.visible_to(user)).to eq(Topic.all)
     end

     it "returns only public topics if user is nil" do
       expect(Topic.visible_to(nil)).to eq([@public_topic])
     end
   end

   describe "publicly viewable" do
     it "returns only public topics if the user is nil" do
       expect(Topic.publicly_viewable(nil)).to eq([@public_topic])
     end
   end

   describe "privately viewable" do
     it "returns only private topics" do
       user = User.new
       expect(Topic.privately_viewable(user)).to eq([@public_topic, @private_topic])
     end
   end
 end

end
