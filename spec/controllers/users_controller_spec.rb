require 'spec_helper'

describe UsersController, :type => :request do
  it 'can get a prize or nil' do
    p '------------------------------------'
    post '/prize', {:user=>{:name=>'王长禄',:phone=>'15831287550'},:format => 'json'}
    response.code.should eq "204"
    # expect{
    #   post :award, {:user=>{:name=>'王长禄',:phone=>'15831287550'}}
    # }.to change(User, :count).by(1)

    # expect {
    #   post :create, {:topic => valid_attributes}, valid_session
    # }.to change(Topic, :count).by(1)
  end
end
