# Supporting the upcoming automation feature

say_status :cloudinary, "Installing the bridgetown-cloudinary plugin..."

cloud_name = ask("What's your Cloudinary cloud name?")

add_bridgetown_plugin "bridgetown-cloudinary"

append_to_file "bridgetown.config.yml" do
  <<~YAML

    cloudinary:
      cloud_name: #{cloud_name}
  YAML
end

say_status :cloudinary, "All set! Double-check the cloudinary block in your config file and review docs at https://github.com/bridgetown/bridgetown-cloudinary"
