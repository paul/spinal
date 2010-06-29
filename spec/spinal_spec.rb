require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Spinal" do

  it 'should work' do
    get '/posts'
    response.should be_ok
  end

  it 'should return 405 Method Not Allowed' do
    put '/posts'
    response.should be_client_error
    response.status.should == 405
  end
end
