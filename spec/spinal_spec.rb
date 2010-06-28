require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Spinal" do

  it 'should work' do
    get '/posts'
    response.should be_ok
  end
end
