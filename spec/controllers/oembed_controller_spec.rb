require 'spec_helper'

describe OembedController do

  describe "GET 'endpoint'" do
    it "returns http success" do
      get 'endpoint'
      response.should be_success
    end
  end

end
