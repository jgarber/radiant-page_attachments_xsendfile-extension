# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class PageAttachmentsXsendfileExtension < Radiant::Extension
  version "2.0"
  description "Sends page attachments with X-Sendfile"
  
  
  def activate
    Page.send :include, PageAttachmentsXsendfile::PageExtensions
    PageAttachment.send :include, PageAttachmentsXsendfile::PageAttachmentExtensions
    SiteController.send :include, PageAttachmentsXsendfile::SiteControllerExtensions
  end
  
  def deactivate
    
  end
  
end