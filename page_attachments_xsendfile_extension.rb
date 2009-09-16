# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class PageAttachmentsXsendfileExtension < Radiant::Extension
  version "2.1"
  description "Sends page attachments with X-Sendfile"
  
  
  def activate
    Page.class_eval {
      include PageAttachmentsXsendfile::PageExtensions
      include PageAttachmentsXsendfile::PageAttachmentTagsExtensions
    }
    PageAttachment.send :include, PageAttachmentsXsendfile::PageAttachmentExtensions
    SiteController.send :include, PageAttachmentsXsendfile::SiteControllerExtensions
  end
  
  def deactivate
    
  end
  
end