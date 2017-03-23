require 'paperclip/railtie'

Paperclip::Railtie.insert

Paperclip::Attachment.default_options[:s3_region] = Rails.application.secrets.aws_s3_region
Paperclip::Attachment.default_options[:region] = Rails.application.secrets.aws_s3_region
Paperclip::Attachment.default_options[:bucket] = Rails.application.secrets.aws_s3_bucket_name
Paperclip::Attachment.default_options[:s3_protocol] = :https
