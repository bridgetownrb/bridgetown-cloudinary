# frozen_string_literal: true

module Bridgetown
  module Cloudinary
    class Builder < Bridgetown::Builder
      include Bridgetown::Filters

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
        ::Cloudinary.config({
          "cloud_name" => config[:cloudinary][:cloud_name],
          "secure"     => true,
        })

        generator :add_image_urls_to_resources
        liquid_tag "cloudinary_img", :img_tag
        liquid_filter "cloudinary_url", :url_filter
        helper "cloudinary_img", :img_helper
        helper "cloudinary_url", :url_filter
      end

      # Populate front matter
      def add_image_urls_to_resources
        Bridgetown::Cloudinary::Utils.add_image_urls_to_resources(
          site, config[:cloudinary]
        )
      end

      # Define the "cloudinary_img" Liquid tag
      def img_tag(attributes, tag)
        alt, id, transformation = attributes.split(",").map(&:strip)
        alt = variable_in_context(alt, tag.context)
        id = variable_in_context(id, tag.context)
        transformation&.delete! '"'

        "<img alt=\"#{alt}\" src=\"#{url_filter(id, transformation)}\" />"
      end

      # Define the "cloudinary_img" Ruby helper
      def img_helper(alt, id, transformation = nil)
        "<img alt=\"#{alt}\" src=\"#{url_filter(id, transformation)}\" />"
      end

      # Define the "cloudinary_url" Liquid filter / Ruby helper
      def url_filter(id, transformation = nil)
        Bridgetown::Cloudinary::Utils.url(
          config: config[:cloudinary], id: id, transformation: transformation
        )
      end

      protected

      def variable_in_context(variable, tag_context)
        if variable.include? '"'
          variable.delete! '"'
        elsif variable.include? "."
          obj, var = variable.split(".")
          variable = tag_context[obj][var]
        else
          variable = tag_context[variable]
        end
        xml_escape(variable)
      end
    end
  end
end
