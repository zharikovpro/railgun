if Rails.env.development? || Rails.env.test?
  Paperclip::Attachment.default_options[:storage] = 'filesystem'
else
  Paperclip::Attachment.default_options.update(
    storage: :s3,
    s3_protocol: 'https',
    s3_credentials: {
      s3_region: ENV.fetch('AWS_REGION', 'us-east-1'),
      bucket: ENV.fetch('BUCKETEER_BUCKET_NAME') { ENV.fetch('AWS_BUCKET') },
      access_key_id: ENV.fetch('BUCKETEER_AWS_ACCESS_KEY_ID') { ENV.fetch('AWS_ACCESS_KEY_ID') },
      secret_access_key: ENV.fetch('BUCKETEER_AWS_SECRET_ACCESS_KEY') { ENV.fetch('AWS_SECRET_ACCESS_KEY') }
    },
    hash_secret: ENV.fetch('PAPERCLIP_HASH_SECRET'),
    path: ':class/:hash.:extension',
    s3_permissions: 'public-read'
    # s3_permissions: :private will allow download only via presigned URLs
    # https://github.com/thoughtbot/paperclip/wiki/Restricting-Access-to-Objects-Stored-on-Amazon-S3
  )
end
