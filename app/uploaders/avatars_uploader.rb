class AvatarsUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/avatars/#{model.try(:id)}"
  end

  version :site do
    process resize_to_fit: [200, 400]
  end

  process :mark

  def mark
    manipulate! do |image|
      nod_av_size = ((image.rows * image.columns) ** 0.5) / 5
      nod_av = Magick::Image.read("#{Rails.root}/app/assets/images/patch.png")[0]
      nod_av.resize!(nod_av_size, nod_av_size)
      image.composite!(nod_av, Magick::SouthWestGravity, Magick::OverCompositeOp)
      image
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
