module PageAttachmentsXsendfile::PageExtensions
  def self.included(base)
    base.send :alias_method_chain, :find_by_url, :attachments
  end
  
  def find_by_url_with_attachments(url, live = true, clean = true)
    page = self.find_by_url_without_attachments(url, live, clean)
    if page.nil? || page.kind_of?(FileNotFoundPage)
      if attachment = attachments.find_by_filename(url.gsub(/^#{Regexp.quote(self.url)}\/?/, '').gsub(/\/$/, ''))
        def attachment.published?; true; end  # FIXME: What is this? Does it need to match self.published??
        return attachment
      end
    end
    return page
  end
end