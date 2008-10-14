module PageAttachmentsXsendfile::PageAttachmentExtensions
  def self.included(base)
    base.send :alias_method_chain, :public_filename, :xsendfile
  end
  
  # Gets the public path to the file, which is a child of the page the 
  # attachment is attached to.  If report.pdf is attached to /president/board
  # then the public path to the file is /president/board/report.pdf.
  # Thumbnails use the original page_attachments extension url scheme 
  # (e.g. /page_attachments/0000/0001/beach_thumb.jpg).
  def public_filename_with_xsendfile(thumbnail = nil)
    if thumbnail || self.page.nil?
      public_filename_without_xsendfile(thumbnail)
    else
      File.join(self.page.url, self.filename)
    end
  end
end