class ImageUploader < CarrierWave::Uploader::Base
  # Include image processing (choose one):
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  # include CarrierWave::Vips

  # Storage configuration
  storage :file
  # storage :fog # For cloud storage

  # Override directory where uploaded files are stored
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Default URL when no file is uploaded
  def default_url(*args)
    ActionController::Base.helpers.asset_path("default-avatar.png")
  end

  # Create different versions
  version :thumb do
    process resize_to_fill: [100, 100]
  end

  version :medium do
    process resize_to_fill: [300, 300]
  end

  version :large do
    process resize_to_fill: [600, 600]
  end

  # Add allowlist of allowed extensions
  def extension_allowlist
    %w(jpg jpeg gif png webp)
  end


end
