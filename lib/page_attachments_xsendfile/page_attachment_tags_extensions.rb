module PageAttachmentsXsendfile::PageAttachmentTagsExtensions
  include Radiant::Taggable
  
  desc %{
    Renders the url or public filename of the attachment for use in links, stylesheets, etc.
    The 'name' attribute is required on this tag or the parent tag.  The optional 'size' attribute
    applies only to images.  
    The optional 'format' attribute specifies whether the URL will be the
    one at /page_attachments/0000/0001/file.jpg (fast--best for images) or the friendly URL that 
    includes the URL of the page it's attached to.  The friendly format takes a little longer to find
    but makes nicer URLs for things like documents.  Fast is the default.

    *Usage*:

    <pre><code><r:attachment:url name="file.jpg" [size="icon"] [format="fast|friendly"]/></code></pre>
  }
  tag "attachment:url" do |tag|
    raise TagError, "'name' attribute required" unless name = tag.attr['name'] or tag.locals.attachment
    page = tag.locals.page
    size = tag.attr['size'] || nil
    format = (tag.attr['format'] == "friendly") || nil
    attachment = tag.locals.attachment || page.attachment(name)
    attachment.public_filename(size, format)
  end

  desc %{
    Renders a hyperlink to the attachment. The 'name' attribute is required on this tag or the parent tag.
    You can use the 'label' attribute to specify the textual contents of the tag.  The format attribute
    specifies whether the link goes directly to the attachment or via a friendly (but slower) alias (which is the
    default for links).  Any other attributes will be added as HTML attributes to the rendered tag.  This tag 
    works as both a singleton and a container.  Any contained content will be rendered inside the resulting link. 
    The optional 'size' attribute applies only to images.

    *Usage*:

    <pre><code><r:attachment:link name="file.jpg" [size="thumbnail"] [format="friendly|fast"]/></code></pre>
    <pre><code><r:attachment:link name="file.jpg" [size="thumbnail"] [format="friendly|fast"]> Some text in the link </r:attachment:link></code></pre>
  }
  tag "attachment:link" do |tag|
    raise TagError, "'name' attribute required" unless name = tag.attr.delete('name') or tag.locals.attachment
    page = tag.locals.page
    attachment = tag.locals.attachment || page.attachment(name)
    label = tag.attr.delete('label') || attachment.filename
    size = tag.attr.delete('size') || nil
    format = tag.attr.delete('format') != "fast"
    filename = attachment.public_filename(size, format) rescue ""
    attributes = tag.attr.inject([]){ |a,(k,v)| a << %{#{k}="#{v}"} }.join(" ").strip
    output = %{<a href="#{filename}"#{" " + attributes unless attributes.empty?}>}
    output << (tag.double? ? tag.expand : label)
    output << "</a>"
  end
end