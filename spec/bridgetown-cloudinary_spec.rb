# frozen_string_literal: true

require "spec_helper"

describe(Bridgetown::Cloudinary) do
  let(:overrides) { {} }
  let(:config) do
    Bridgetown.configuration(Bridgetown::Utils.deep_merge_hashes({
      "full_rebuild" => true,
      "root_dir"     => root_dir,
      "source"       => source_dir,
      "destination"  => dest_dir
    }, overrides))
  end
  let(:metadata_overrides) { {} }
  let(:metadata_defaults) do
    {
      "name" => "My Awesome Site",
      "author" => {
        "name" => "Ada Lovejoy",
      }
    }
  end
  let(:site) { Bridgetown::Site.new(config) }
  let(:contents) { File.read(dest_dir("index.html")) }
  before(:each) do
    metadata = metadata_defaults.merge(metadata_overrides).to_yaml.sub("---\n", "")
    File.write(source_dir("_data/site_metadata.yml"), metadata)
    site.process
    FileUtils.rm(source_dir("_data/site_metadata.yml"))
  end

  context "Liquid tag" do
    it "outputs with an inline id" do
      expect(contents).to match '<img alt="This is inline" src="https://res.cloudinary.com/bridgetown_test/image/upload/c_fill,g_face:center,w_1600,h_900,q_50/inline_id.jpg" />'
    end

    it "outputs with a page variable" do
      expect(contents).to match '<img alt="This is page" src="https://res.cloudinary.com/bridgetown_test/image/upload/c_fill,g_face:center,w_1600,h_900,q_50/the_id_123.jpg" />'
    end

    it "outputs with a local object" do
      expect(contents).to match '<img alt="This is local object" src="https://res.cloudinary.com/bridgetown_test/image/upload/c_fill,g_face:center,w_1600,h_900,q_50/the_id_123.jpg" />'
    end

    it "outputs with a local variable" do
      expect(contents).to match '<img alt="This is local variable" src="https://res.cloudinary.com/bridgetown_test/image/upload/c_fill,g_face:center,w_1600,h_900,q_50/local_id.jpg" />'
    end
  end

  context "transformations" do
    it "outputs a custom transformation" do
      expect(contents).to match '<img alt="Transformation" src="https://res.cloudinary.com/bridgetown_test/image/upload/w_4096,c_limit,q_65/local_id.jpg" />'
    end
  end

  context "Liquid filter" do
    it "outputs a URL" do
      expect(contents).to match "https://res.cloudinary.com/bridgetown_test/image/upload/c_fill,g_face:center,w_1600,h_900,q_50/filtered_id.jpg"
    end

    it "outputs a URL with custom transformation" do
      expect(contents).to match "https://res.cloudinary.com/bridgetown_test/image/upload/w_1200,c_limit,q_80/filtered_id_max.jpg"
    end
  end

  context "image generator" do
    it "should set the page's image variable default path" do
      expect(contents).to match "image: https://res.cloudinary.com/bridgetown_test/image/upload/c_fill,g_face:center,w_1600,h_900,q_50/the_id_123.jpg"
    end

    it "should set the page's image variable tiny path" do
      expect(contents).to match "tiny: https://res.cloudinary.com/bridgetown_test/image/upload/w_300,c_limit,q_90/the_id_123.jpg"
    end
  end
end
