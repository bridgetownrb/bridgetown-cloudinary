# Supporting the upcoming automation feature

cloud_name = ask("What's your Cloudinary cloud name?")

run "bundle add bridgetown-cloudinary -g bridgetown_plugins"

append_to_file "bridgetown.config.yml" do
  <<~YAML

    cloudinary:
      cloud_name: #{cloud_name}
  YAML
end
