class CommonImage < ActiveRecord::Base
  require 'rmagick'
  require 'open-uri'
  include Magick

  @@temp_file_path = Rails.application.config.aws_temp_path

  # Upload Image from File
  def self.upload_from_file file, versions, class_name
    self.upload_image file.tempfile, versions, class_name
  end


  # Method to upload All Images
  def self.push_to_aws file_path, file_name

    aws_credentials = Rails.application.config.aws_credentials
    s3 = self.aws_connection aws_credentials

    #TODO: add content type and expiry
    # Reference the target object by bucket name and key.
    obj = s3.bucket(aws_credentials[:bucket]).object(file_name)

    # Call upload_file on the object.
    obj.upload_file(file_path, acl: 'public-read')
    return obj.public_url
  end

  def self.upload_image path, versions, class_name

    new_img = class_name.constantize.new({
                                             :original => self.push_to_aws(path, SecureRandom.uuid + File.extname(path)) # Not sure if its ok to force an extension.
                                         })
    versions.each do |k, v|
      temp_file_name = SecureRandom.uuid
      temp_file_path = @@temp_file_path

      resized_img = self.resize_img(v, path)
      resized_img.write("#{temp_file_path}/#{temp_file_name}"){self.quality=60}


      url = self.push_to_aws "#{temp_file_path}/#{temp_file_name}", temp_file_name

      new_img[k] = url
      File.delete("#{temp_file_path}/#{temp_file_name}") if File.exist?("#{temp_file_path}/#{temp_file_name}")
    end
    new_img.save
    new_img
  end



  def self.resize_img version, path
    binary = File.open(path, 'r') {|f| f.read.force_encoding(Encoding::UTF_8)}
    image = ImageList.new().from_blob(binary)
    if version[1] == nil
      width = version[0]
      height = (version[0] * image.rows) / image.columns
      return image.resize_to_fill(width, height)
    else
      return image.resize_to_fill(version[0], version[1])
    end
  end

  def self.aws_connection aws_credentials
    Aws::S3::Resource.new(
        credentials: Aws::Credentials.new(aws_credentials[:access_key], aws_credentials[:secret_access_key]),
        region: aws_credentials[:region]
    )
  end

end
