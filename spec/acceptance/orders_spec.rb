require 'rails_helper'
require 'rspec_api_documentation/dsl'
resource "Pages" do
  get "/api/v1/pages" do
    example "Listing orders" do
      do_request

      status.should == 200
    end
  end
end