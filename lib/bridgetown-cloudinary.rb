# frozen_string_literal: true

require "bridgetown"
require "cloudinary"
require "bridgetown-cloudinary/utils"
require "bridgetown-cloudinary/builder"

# rubocop:disable Metrics/ParameterLists
Bridgetown.initializer :"bridgetown-cloudinary" do |config,
  cloud_name: nil,
  default_transformation: "open_graph",
  default_image_format: "jpg",
  transformations: {},
  add_transformed_urls_to_image_front_matter: false|

  options = {
    default_transformation: default_transformation,
    default_image_format: default_image_format,
    transformations: {
      open_graph: "c_fill,g_face:center,w_1600,h_900,q_50",
      tiny: "w_300,c_limit,q_90",
      small: "w_600,c_limit,q_85",
      medium: "w_1200,c_limit,q_80",
      large: "w_1800,c_limit,q_80",
      xlarge: "w_2048,c_limit,q_75",
    }.merge(transformations),
    add_transformed_urls_to_image_front_matter: add_transformed_urls_to_image_front_matter,
  }

  if config.cloudinary
    config.cloudinary Bridgetown::Utils.deep_merge_hashes(options, config.cloudinary)
  else
    config.cloudinary(options)
  end
  config.cloudinary.cloud_name = cloud_name if cloud_name

  config.builder Bridgetown::Cloudinary::Builder
end
# rubocop:enable Metrics/ParameterLists
