require File.dirname(__FILE__) + '/../spec_helper'

describe PageAttachment do
  dataset :page_attachments
  
  before do
    @page = pages(:first)
    @attachment = page_attachments(:first)
  end
  
  describe "#public_filename" do
    it "should be extended by xsendfile" do
      @attachment.should respond_to(:public_filename_with_xsendfile)
      @attachment.should respond_to(:public_filename_with_friendly_url_switching)
      @attachment.should respond_to(:public_filename_without_friendly_url_switching)
    end
    
    it "should be under the page it is attached to when second param is true" do
      @attachment.public_filename(nil, true).should == File.join(@page.url, @attachment.filename)
    end
    
    it "should be at the normal URL by default" do
      @attachment.public_filename.should =~ /\/page_attachments\/\d{4}\/\d{4}/
    end
  end

end