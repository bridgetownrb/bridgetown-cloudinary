# frozen_string_literal: true

module Bridgetown
  module Cloudinary
    module Utils
      def self.url(config:, id:, transformation:)
        transformation = if transformation
                           "/#{config[:transformations][transformation]}"
                         else
                           "/#{config[:transformations][config[:default_transformation]]}"
                         end
        image_format = config[:default_image_format]

        cloudinary_url = ::Cloudinary::Utils.cloudinary_url(
          id, { format: image_format }
        )

        cloudinary_url&.sub("/image/upload", "/image/upload#{transformation}")
      end

      def self.add_image_urls_to_documents(site, cloudinary_config)
        (site.documents + site.pages).each do |page|
          if page.data[:cloudinary_id] && !page.data[:image]
            page.data[:image] = {
              path: url(
                config: cloudinary_config,
                id: page.data[:cloudinary_id],
                transformation: nil
              )
            }
            if cloudinary_config[:add_transformed_urls_to_image_front_matter]
              cloudinary_config[:transformations].each_key do |transformation|
                page.data[:image][transformation] = url(
                  config: cloudinary_config,
                  id: page.data[:cloudinary_id],
                  transformation: transformation
                )
              end
            end
          end
        end
      end
    end
  end
end
