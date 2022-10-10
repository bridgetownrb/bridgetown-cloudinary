# Supporting the upcoming automation feature

say_status :cloudinary, "Installing the bridgetown-cloudinary plugin..."

cloud_name = ask("What's your Cloudinary cloud name?")

add_gem "bridgetown-cloudinary"

add_initializer :"bridgetown-cloudinary" do
  <<~RUBY
     do
      cloud_name "#{cloud_name}"
    end
  RUBY
end

say_status :cloudinary, "All set! Double-check the cloudinary block in your config/initializers.rb file and review docs at"
say_status :cloudinary, "https://github.com/bridgetownrb/bridgetown-cloudinary"
