require File.dirname(__FILE__) + '/../spec_helper'

describe PageAttachment do
  scenario :page_attachments
  
  before do
    @page = pages(:first)
    @attachment = page_attachments(:first)
  end
  
  describe "#public_filename" do
    it "should be extended by xsendfile" do
      @attachment.should respond_to(:public_filename_with_xsendfile)
      @attachment.should respond_to(:public_filename_without_xsendfile)
    end
    
    it "should be under the page it is attached to" do
      @attachment.public_filename.should == File.join(@page.url, @attachment.filename)
    end
  end

end