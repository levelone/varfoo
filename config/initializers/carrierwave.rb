CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                                      # required
    :aws_access_key_id      => 'AKIAIWNCWZHOMH2D3C3A',                     # required
    :aws_secret_access_key  => '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'  # required
    # :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
    # :host                   => 's3.varfoo.com',              # optional, defaults to nil
    # :endpoint               => 'https://s3.varfoo.com:8080'  # optional, defaults to nil
  }
  config.fog_directory  = Rails.env == 'development' ? 'varfoo-development' : 'varfoo-production' # required
  config.fog_public     = true                                    # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end