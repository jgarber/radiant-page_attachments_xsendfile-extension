# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class PageAttachmentsXsendfileExtension < Radiant::Extension
  version "1.0"
  description "Sends page attachments with X-Sendfile"
  
  
  def activate
    Page.send :include, PageAttachmentsXsendfile::PageExtensions
    PageAttachment.send :include, PageAttachmentsXsendfile::PageAttachmentExtensions
    SiteController.send :include, PageAttachmentsXsendfile::SiteControllerExtensions
    
    # Include X-Sendfile support backported from Rails 2.1
    SiteController.send :include, PageAttachmentsXsendfile::ActionControllerStreamingExtensions unless ActionController::Streaming.const_defined?(:X_SENDFILE_HEADER)
  end
  
  def deactivate
    
  end
  
end