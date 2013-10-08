# encoding: utf-8
class AvatarsUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :fog

  def store_dir
    "uploads/avatars/#{model.id}"
  end

  process :mark

  def mark
    manipulate! do |image|
      nod_av = Magick::Image.read("#{Rails.root}/app/assets/images/on_avatar.png").first
      image.composite!(nod_av, Magick::SouthWestGravity, Magick::OverCompositeOp)
      image
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
