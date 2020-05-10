# frozen_string_literal: true

module Bridgetown
  module Cloudinary
    class Builder < Bridgetown::Builder
      CONFIG_DEFAULTS = {
        cloudinary: {
          cloud_name: nil,
          default_transformation: "open_graph",
          default_image_format: "jpg",
          transformations: {
            open_graph: "c_fill,g_face:center,w_1600,h_900,q_50",
            tiny: "w_300,c_limit,q_90",
            small: "w_600,c_limit,q_85",
            medium: "w_1200,c_limit,q_80",
            large: "w_1800,c_limit,q_80",
            xlarge: "w_2048,c_limit,q_75",
          },
          add_transformed_urls_to_image_front_matter: false,
        },
      }.freeze

      # Set up the Cloudinary configuration
      def build
        cloudinary_config = config[:cloudinary]

        ::Cloudinary.config({
          "cloud_name" => cloudinary_config[:cloud_name],
          "secure"     => true,
        })

        setup_tag(cloudinary_config)
        setup_filter(cloudinary_config)

        generator do
          Bridgetown::Cloudinary::Utils.add_image_urls_to_documents(
            site, cloudinary_config
          )
        end
      end

      # Define the "cloudinary_img" Liquid tag
      def setup_tag(cloudinary_config)
        liquid_tag "cloudinary_img" do |attributes, context|
          alt, id, transformation = attributes.split(",").map(&:strip)
          alt.delete! '"'
          if id.include? '"'
            id.delete! '"'
          elsif id.include? "."
            obj, var = id.split(".")
            id = context[obj][var]
          else
            id = context[id]
          end
          transformation&.delete! '"'

          cloudinary_url = Bridgetown::Cloudinary::Utils.url(
            config: cloudinary_config, id: id, transformation: transformation
          )
          "<img alt=\"#{alt}\" src=\"#{cloudinary_url}\" />"
        end
      end

      # Define the "cloudinary_url" Liquid filter
      def setup_filter(cloudinary_config)
        liquid_filter "cloudinary_url" do |id, transformation = nil|
          Bridgetown::Cloudinary::Utils.url(
            config: cloudinary_config, id: id, transformation: transformation
          )
        end
      end
    end
  end
end

Bridgetown::Cloudinary::Builder.register
