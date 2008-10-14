module PageAttachmentsXsendfile::ActionControllerStreamingExtensions
  def self.included(base)
    base.send :alias_method_chain, :send_file, :xsendfile
  end
  
  DEFAULT_SEND_FILE_OPTIONS = {
    :type         => 'application/octet-stream'.freeze,
    :disposition  => 'attachment'.freeze,
    :stream       => true,
    :buffer_size  => 4096,
    :x_sendfile   => false
  }.freeze

  X_SENDFILE_HEADER = 'X-Sendfile'.freeze
  
  # Rails 2.1 has X-Sendfile capabilities built-in, but as of Radiant 0.6.9,
  # it runs on Rails 2.0.2.  Backporting that capability.
  def send_file_with_xsendfile(path, options = {})
    raise MissingFile, "Cannot read file #{path}" unless File.file?(path) and File.readable?(path)

    options[:length]   ||= File.size(path)
    options[:filename] ||= File.basename(path) unless options[:url_based_filename]
    send_file_headers! options

    @performed_render = false

    if options[:x_sendfile]
      logger.info "Sending #{X_SENDFILE_HEADER} header #{path}" if logger
      head options[:status], X_SENDFILE_HEADER => path
    else
      if options[:stream]
        render :status => options[:status], :text => Proc.new { |response, output|
          logger.info "Streaming file #{path}" unless logger.nil?
          len = options[:buffer_size] || 4096
          File.open(path, 'rb') do |file|
            while buf = file.read(len)
              output.write(buf)
            end
          end
        }
      else
        logger.info "Sending file #{path}" unless logger.nil?
        File.open(path, 'rb') { |file| render :status => options[:status], :text => file.read }
      end
    end
  end
end