{spawn}  = require 'child_process'
util     = require 'util'
deferred = require 'deferred'

{Course} = require('../models')


log = (x) ->
  console.log util.inspect x,
    showHidden: true
    colors: true
    depth: 1


module.exports = (req, res) ->
    if not SCRAPING
      SCRAPING = true
      scraper = spawn './server/scraper/index.sh'
      scraper_p = deferred().promise
      i = 0
      scraper.stdout.on 'data', (courses) ->
        for c in JSON.parse courses.toString()
          log c.name if i%100 is 0
          scraper_p Course.findOrCreate(c.name, c)
          i++
      scraper.stderr.on 'data', (data) ->
        console.log data.toString 'utf8'
      scraper.on 'close', (code) ->
        SCRAPING = false
        if code isnt 0
          log 'scraper exited with code ' + code
        else
          scraper_p.done ->
            log 'Saved all the courses!'
      res.redirect '/'

