require 'spec_helper'

describe "home/support.html.haml" do
  before do
    visit support_path
  end
  it "displays localized header" do
    page.should have_content(t(:'home.support.title'))
  end
  it "displays the content of About Page" do
    page.should have_content("no content yet")
  end
end
