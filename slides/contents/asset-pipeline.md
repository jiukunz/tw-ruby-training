# Asset Pipeline

---

## Manage Asset

- JS
- CSS
- Image
- Font

---

## Compression

```ruby
config.assets.css_compressor = :yui
config.assets.js_compressor = :uglifier
```
sass-rails will automatically compress CSS

---
## Asset Organization
- app/assets is for assets that are owned by the application, such as custom images, JavaScript files or stylesheets.
- lib/assets is for your own libraries' code that doesn't really fit into the scope of the application or those libraries which are shared across applications.
- vendor/assets is for assets that are owned by outside entities, such as code for JavaScript plugins and CSS frameworks. Keep in mind that third party code with references to other files also processed by the asset Pipeline (images, stylesheets, etc.)
---

## Fingerprinting

**global-908e25f4bf641868d8683022a5b62f54.css**

```ruby
# assets need list in production.rb
config.assets.precompile += ['admin.js', 'admin.css']
```
---
## Manifest Files

in development: /assets/application.js?body=1

in production: /assets/application-908e25f4bf641868d8683022a5b62f54.js

```ruby
# manifest.yml
{
  "files": {
    "application-723d1be6cc741a3aabb1cec24276d681.js": {
      "logical_path": "application.js",
      "mtime": "2013-07-26T22:55:03-07:00",
      "size": 302506,
      "digest": "723d1be6cc741a3aabb1cec24276d681"
    },
  },
  "assets": {
    "application.js": "application-723d1be6cc741a3aabb1cec24276d681.js"
  }
}

```

---
## CDN & Asset
- make production serve assets
- buy a CDN service
- set production url to CDN service
- set CDN url to rails config, like
```ruby
config.action_controller.asset_host = 'mycdnsubdomain.fictional-cdn.com'
```
---
#Q & A
