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

      def self.add_image_urls_to_resources(site, config) # rubocop:todo Metrics/CyclomaticComplexity
        site.contents.each do |resource|
          next unless resource.data[:cloudinary_id] && !resource.data[:image]
          next if resource.respond_to?(:collection) && resource.collection.data?

          resource.data[:image] = {
            path: url(
              config: config,
              id: resource.data[:cloudinary_id],
              transformation: nil
            ),
          }
          next unless config[:add_transformed_urls_to_image_front_matter]

          config[:transformations].each_key do |transformation|
            resource.data[:image][transformation] = url(
              config: config,
              id: resource.data[:cloudinary_id],
              transformation: transformation
            )
          end
        end
      end
    end
  end
end
