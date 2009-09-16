module PageAttachmentsXsendfile::SiteControllerExtensions
  def self.included(base)
    base.send :alias_method_chain, :show_page, :attachments
  end


  def show_page_with_attachments
    url = params[:url]
    if Array === url
      url = url.join('/')
    else
      url = url.to_s
    end

    @page = find_page(url)
    unless @page.nil?
      if @page.is_a?(PageAttachment)
        send_file(@page.full_filename, :x_sendfile => true, :type => @page.content_type, :disposition => 'inline')
      else
        process_page(@page)
        set_cache_control
        @performed_render ||= true
      end
    else
      render :template => 'site/not_found', :status => 404
    end
  rescue Page::MissingRootPageError
    redirect_to welcome_url
  end

end