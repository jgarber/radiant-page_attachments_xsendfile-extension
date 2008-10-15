module PageAttachmentsXsendfile::SiteControllerExtensions
  def self.included(base)
    base.send :alias_method_chain, :show_uncached_page, :attachments
  end


  def show_uncached_page_with_attachments(url)
    @page = find_page(url)
    unless @page.nil?
      if @page.is_a?(PageAttachment)
        x_send_file(@page.full_filename, :type => @page.content_type, :disposition => 'inline')
      else
        process_page(@page)
        @cache.cache_response(url, response) if request.get? and live? and @page.cache?
        @performed_render = true
      end
    else
      render :template => 'site/not_found', :status => 404
    end
  rescue Page::MissingRootPageError
    redirect_to welcome_url
  end
end