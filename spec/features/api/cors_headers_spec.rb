require 'spec_helper'

=begin
RSpec.feature "the requests support CORS headers", type: :feature, issues: [113] do
  scenario 'Send the CORS preflight OPTIONS request' do
    integration_session.__send__(:process, :options, '/api/v1/pages')

    expect(response.headers['Access-Control-Allow-Origin']).to eq('http://super-test.com')
    expect(response.headers['Access-Control-Allow-Methods']).to eq('OPTIONS, GET, POST, PUT, PATCH, DELETE')
    expect(response.headers['Access-Control-Allow-Headers']).to be_nil
    expect(response.headers).to have_key('Access-Control-Max-Age')
  end
end
=end
