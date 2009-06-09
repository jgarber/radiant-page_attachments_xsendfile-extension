require File.dirname(__FILE__) + '/../spec_helper'

describe PageAttachmentTags do
  dataset :pages, :page_attachments
  
  FAST_URL_PATTERN = /\/page_attachments\/\d{4}\/\d{4}/

  before do
    @page = pages(:first)
    @attachment = page_attachments(:first)
  end
  
  it "should render attachment url in normal format by default" do
    @page.should render('<r:attachment:url name="rails.png" />').matching(FAST_URL_PATTERN)
    @page.should render('<r:attachment:url name="rails.png" format="fast" />').matching(FAST_URL_PATTERN)
  end
  it "should render attachment url in friendly format when option is set" do
    @page.should render('<r:attachment:url name="rails.png" format="friendly" />').as(File.join(@page.url, @attachment.filename))
  end
  
  it "should always use the fast URL format for images" do
    expected = %{<img src="#{@attachment.public_filename}" />}
    @page.should render('<r:attachment:image name="rails.png" />').as(expected)
  end

  it "should link to a url in the friendly format by default" do
    expected = %Q{<a href="#{File.join @page.url, @attachment.filename}">#{@attachment.filename}</a>}
    @page.should render('<r:attachment:link name="rails.png" />').as(expected)
    @page.should render('<r:attachment:link name="rails.png" format="friendly" />').as(expected)
  end
  it "should link to a url in the normal format when option is set to 'fast'" do
    @page.should render('<r:attachment:link name="rails.png" format="fast" />').matching(FAST_URL_PATTERN)
  end
end