require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  dataset :page_attachments, :file_not_found
  
  before do
    @page = pages(:first)
    @attachment = page_attachments(:first)
  end
  
  describe "#find_by_url" do
    
    it "should be extended by xsendfile" do
      @page.should respond_to(:find_by_url_with_attachments)
      @page.should respond_to(:find_by_url_without_attachments)
    end
    
    it "should return an attachment when there is one" do
      attachment_url = File.join(@page.url, @attachment.filename)
      Page.find_by_url(attachment_url).should == @attachment
    end
    
    it "should find the FileNotFoundPage when an attachment does not exist" do
      attachment_url = File.join(@page.url, "nothing-here")
      Page.find_by_url(attachment_url).should == pages(:file_not_found)
    end
  end
  
end