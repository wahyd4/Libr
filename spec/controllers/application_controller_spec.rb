require 'spec_helper'
class ApplicationControllerSpec
  #shared_examples_for "any request" do
  #  context "CORS requests" do
  #    it "should set the Access-Control-Allow-Origin header to allow CORS from anywhere" do
  #      response.headers['Access-Control-Allow-Origin'].should == '*'
  #    end
  #
  #    it "should allow general HTTP methods thru CORS (GET/POST/PUT/DELETE)" do
  #      allowed_http_methods = response.header['Access-Control-Allow-Methods']
  #      %w{GET POST PUT DELETE}.each do |method|
  #        allowed_http_methods.should include(method)
  #      end
  #    end
  #
  #    # etc etc
  #  end
  #end
  #
  #describe "HTTP OPTIONS requests" do
  #  # With Rails 4 (currently in master) we'll be able to `options :index`
  #  before(:each) { process :index, nil, nil, nil, 'OPTIONS' }
  #
  #  it_should_behave_like "any request"
  #
  #  it "should be succesful" do
  #    response.should be_success
  #  end
  #end
end