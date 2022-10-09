# frozen_string_literal: true

require "bridgetown"
require "cloudinary"
require "bridgetown-cloudinary/utils"
require "bridgetown-cloudinary/builder"

Bridgetown.initializer :"bridgetown-cloudinary" do |config|
  config.builder Bridgetown::Cloudinary::Builder
end
