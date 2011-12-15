require 'spec_helper'

describe "home/about.html.haml" do
  before do
    visit about_path
  end
  it "displays localized header" do
    page.should have_content(t(:'home.about.title'))
  end
  it "displays the content of About Page" do
    page.should have_content("no content yet")
  end
end
