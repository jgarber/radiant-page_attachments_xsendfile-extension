# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class PageAttachmentsXsendfileExtension < Radiant::Extension
  version "1.0"
  description "Sends page attachments with X-Sendfile"
  
  
  def activate
    Page.class_eval {
      include PageAttachmentsXsendfile::PageExtensions
      include PageAttachmentsXsendfile::PageAttachmentTagsExtensions
    }
    PageAttachment.send :include, PageAttachmentsXsendfile::PageAttachmentExtensions
    SiteController.send :include, PageAttachmentsXsendfile::SiteControllerExtensions

    # Include x_send_file Rails plugin
    ActionController::Base.send(:include, XSendFile::Controller)
  end
  
  def deactivate
    
  end
  
end