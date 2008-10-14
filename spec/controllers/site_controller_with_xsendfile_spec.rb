require File.dirname(__FILE__) + '/../spec_helper'

describe SiteController, 'with xsendfile' do
  scenario :page_attachments
  
  before do
    @page = pages(:first)
    @attachment = page_attachments(:first)
    File.stub!(:file?).and_return(true)
    File.stub!(:readable?).and_return(true)
    File.stub!(:size).and_return(@attachment.size)
  end
  
  
  describe "alias chain" do
    it "should be set up" do
      controller.should respond_to(:show_uncached_page_with_attachments)
      controller.should respond_to(:send_file_with_xsendfile)
    end
  end
  
  it "should find an attachment under the page it's attached to" do
    get :show_page, :url => 'first/rails.png'
    response.should be_success
    response.headers.should include("X-Sendfile")
    response.headers["X-Sendfile"].should == @attachment.full_filename
    
    # assert @response.headers.include?('X-Sendfile'), 'X-Sendfile header expected'
    # assert_match(/#{page_attachments(:rails_png).filename}$/, @response.headers['X-Sendfile'])
    # assert_equal(attachment.content_type, @response.headers['Content-Type'])
    # assert_not_nil(@response.headers['Content-Length'])
    # assert_match(/#{page_attachments(:rails_png).filename}/, @response.headers['Content-Disposition'])
  end

end