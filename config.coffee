exports.config =
  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^(?!app)/

    stylesheets:
      joinTo: 'stylesheets/app.css'

    templates:
      joinTo:
        'javascripts/templates.js': /.+\.jade$/

  plugins:
    jade:
      options:
        pretty: yes
    static_jade:
      extensions: ".static.jade"
