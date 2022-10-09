# frozen_string_literal: true

Bridgetown.configure do
  # partial config here, also in bridgetown.config.yml
  init :"bridgetown-cloudinary" do
    cloud_name "bridgetown_test"
    add_transformed_urls_to_image_front_matter true
  end
end
