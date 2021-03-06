require 'spec_helper'

describe LightWeb do
  let(:server) {
    LightWeb.draw do
      get '/user' do
        "This is the user response"
      end

      post '/user' do
        "User created"
      end

      put '/user/:id' do
        "User #{params[:id]} updated"
      end

      delete "/user/:id" do
        "User #{params[:id]} deleted"
      end

      not_found do
        'not found'
      end
    end
  }

  subject { server.recieve(method, uri) }

  context "get" do
    let(:method) { 'GET' }
    let(:uri) { "/user" }
    it "be responded" do
      subject.should eq("This is the user response")
    end
  end

  context "post" do
    let(:method) { 'POST' }
    let(:uri) { "/user" }
    it "be responded" do
      subject.should eq("User created")
    end
  end

  context "put" do
    let(:method) { 'PUT' }
    let(:uri) { "/user/1" }
    it "be responded" do
      subject.should eq("User 1 updated")
    end
  end

  context "delete" do
    let(:method) { 'DELETE' }
    let(:uri) { "/user/1" }
    it "be responded" do
      subject.should eq("User 1 deleted")
    end
  end

  context "method not matched" do
    let(:method) { 'HEAD' }
    let(:uri) { "/user" }
    it "be responded" do
      subject.should eq('not found')
    end
  end

  context "uri not matched" do
    let(:method) { 'GET' }
    let(:uri) { "/dogs" }
    it "be responded" do
      subject.should eq('not found')
    end
  end
end
