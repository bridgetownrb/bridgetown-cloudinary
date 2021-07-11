# Bridgetown Cloudinary Plugin

[Bridgetown](https://www.bridgetownrb.com) is a Ruby-powered static site generator.
[Cloudinary](https://www.cloudinary.com) is digital asset management service which
makes uploading and serving resized, transformed, and compressed images and videos
easy and fast.

This plugin wires the two up so you can use Cloudinary images in your blog posts,
articles, product pages, site templates, and anywhere else you might need to
reference media optimized for mobile and responsive design.

(_Note: For users who may be familiar with the jekyll-cloudinary plugin, this is
unrelated and the usage is quite different. This plugin assumes you store your
images in Cloudinary directly, not your repo._)

## Installation

You can install this plugin via an automation to guide you through the configuration:

```shell
bundle exec bridgetown apply https://github.com/bridgetownrb/bridgetown-cloudinary
```

Otheriwse, you can run this command to add this plugin to your site's Gemfile:

```shell
$ bundle add bridgetown-cloudinary -g bridgetown_plugins
```

Then modify your `bridgetown.config.yml` configuration to point to your Cloudinary
cloud name:

```yaml
cloudinary:
  cloud_name: my-cloud-name
```

## Usage

The simplest usage of the Bridgetown Cloudinary plugin is to add a `cloudinary_id` to
the front matter of a resource. For example:

```yaml
---
title: I'm a Blog Post
cloudinary_id: some-folder-with/image-in-cloudinary
category: neat
---

I'm a blog post with an image!
```

The plugin will automatically add `image.path` front matter with a generated URL to
the image in Cloudinary using the default configured transformation `open_graph`.
This sizes and compresses an image suitable for use on Twitter, Facebook, etc.
(See below for information on how to change the default transformation or add your
own.)

You can use `image.path` in a template:

`{{ post.image.path }}`

Since `image.path` is also referenced by the Bridgetown [Feed](https://github.com/bridgetownrb/bridgetown-feed) and [SEO](https://github.com/bridgetownrb/bridgetown-seo-tag) plugins,
your Cloudinary images will be picked up in those contexts automatically.

To reference other available sizes, you can use either a Liquid tag or filter, or Ruby helper,
depending on your needs. Using a tag:

`{% cloudinary_img "Alt text goes here", post.cloudinary_id, "large" %}`

Or a filter:

`<img alt="Alt text" src="{{ post.cloudinary_id | cloudinary_url: "medium" }}" />`

Or helpers in ERB and other Ruby templates:

`<%= cloudinary_img "Alt text goes here", post.data.cloudinary_id %>`

`<img alt="Alt text" src="<%= cloudinary_url post.data.cloudinary_id, :medium %>" />`

### Default Sizes Included

Here's a list of all the Cloudinary transformation strings that ship with the plugin:

```yaml
open_graph: "c_fill,g_face:center,w_1600,h_900,q_50" # default
tiny: "w_300,c_limit,q_90"
small: "w_600,c_limit,q_85"
medium: "w_1200,c_limit,q_80"
large: "w_1800,c_limit,q_80"
xlarge: "w_2048,c_limit,q_75"
```

The image format used in all cases is JPG.

### Optional Configuration Options

If you'd like to reference any of the configured image sizes directly through front
matter as an alternative to using tags or filters, you can switch this on in your
`bridgetown.config.yml`:

```yaml
cloudinary:
  add_transformed_urls_to_image_front_matter: true
```

Then you'll be able to reference image sizes like so:

`<img alt="Alt text" src="{{ post.image.tiny }}" />`

Be aware that if an `image` front matter variable has already defined for a document,
it will remain intact and the Cloudinary image transformations won't be apply for
that document.

You can also change or add your own transformations! Simply define them in your
config:

```yaml
cloudinary:
  transformations:
    tiny: w_300,c_limit,q_90 # this overrides the builtin tiny transformation
    max_bw: e_grayscale,w_4096,c_limit,q_65 # this is a new custom transformation
```

If you configure transformations to get added to front matter, all custom
transformations will show up there as well:

`B&W image URL: {{ post.image.max_bw }}`

## Testing

* Run `bundle exec rspec` to run the test suite
* Or run `script/cibuild` to validate with Rubocop and test with rspec together

## Contributing

1. Fork it (https://github.com/bridgetownrb/bridgetown-cloudinary/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Releasing

To release a new version of the plugin, simply bump up the version number in
`version.rb` and then run `script/release`.
