# Supporting the upcoming automation feature

say_status "Cloudinary", "Installing the bridgetown-cloudinary plugin..."

cloud_name = ask("What's your Cloudinary cloud name?")

add_bridgetown_plugin "bridgetown-sample-plugin"

append_to_file "bridgetown.config.yml" do
  <<~YAML

    cloudinary:
      cloud_name: #{cloud_name}
  YAML
end
