View = require 'views/base/view'

module.exports = class FourOhFourView extends View
  autoRender: yes
  template: require './templates/fourOhFour'

