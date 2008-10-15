# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class PageAttachmentsXsendfileExtension < Radiant::Extension
  version "1.0"
  description "Sends page attachments with X-Sendfile"
  
  
  def activate
    Page.send :include, PageAttachmentsXsendfile::PageExtensions
    PageAttachment.send :include, PageAttachmentsXsendfile::PageAttachmentExtensions
    SiteController.send :include, PageAttachmentsXsendfile::SiteControllerExtensions

    # Include x_send_file Rails plugin
    require 'x_send_file'
    ActionController::Base.send(:include, XSendFile::Controller)
  end
  
  def deactivate
    
  end
  
end