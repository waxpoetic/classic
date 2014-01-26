if defined? AssetSync
  AssetSync.configure do |config|
    # Sync assets to the S3 bucket
    config.fog_provider = 'AWS'
    config.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
    config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    config.fog_directory = 'assets.waxpoeticrecords.com'

    # Increase upload performance by configuring your region
    config.fog_region = 'us-east-1'

    # Automatically replace files with their equivalent gzip compressed version
    config.gzip_compression = true

    # Use the Rails generated 'manifest.yml' file to produce the list of files to
    # upload instead of searching the assets directory.
    config.manifest = true

    # Fail silently.  Useful for environments such as Heroku
    config.fail_silently = true
  end
end
