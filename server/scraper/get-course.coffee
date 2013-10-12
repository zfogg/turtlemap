#!/bin/node.io -s


nodeio = require 'node.io'
qs     = require 'querystring'
util   = require 'util'
jquery = require 'jquery'
{tidy} = require 'htmltidy'


log = (x) ->
  console.log util.inspect x,
    showHidden: true
    colors: true
    depth: 1


$log = ($x) =>
  opts =
    indent: true
    'omit-optional-tags': 'true'
    wrap: 130
  tidy $x.html(), opts, (err, html) =>
    console.log html

parseDays = (days) ->
  # Input will be string of letters representing weekdays.
  # Example: "MTuWThF"
  days = days.replace(/([A-Z]{1}[uh]?)/g, "$1,").split(',')
  if days[days.length-1] is ''
    days.pop()
  days


SOC_URL      = "https://ntst.umd.edu/soc/"
COURSE_URL   = SOC_URL+"search?termId=201308&"
SECTIONS_URL = SOC_URL+"201308/sections.html?"


class CourseScrape extends nodeio.JobClass
  run: (course_name) ->
    #TODO: not this
    courses = []

    @getHtml COURSE_URL + (qs.stringify courseId: course_name), (err, $, page) =>
      $$ = (html) ->
        (sel) -> jquery sel, html
      _$ = $; $ = $$ page

      if 0 is $('.toggle-sections-link-container').length
        # If this course has no sections listed.
        return @emit "[]"

      @get SECTIONS_URL + (qs.stringify courseIds: course_name), (err, sections) =>
        $course   = $$ $ "##{course_name}"
        $sections = $$ sections

        for sec in $sections '.section'
          $sec = $$ sec
          for course in $sec '.class-days-container > .row'
            $course = $$ course

            course_data =
              name       : course_name
              section    : $sec('.section-id').text().trim()
              title      : $course('.course-title').text()
              type       : $course('.class-type').text() or undefined
              instructor : $sec('.section-instructor').text()
              credits    : $("##{course_name} .course-min-credits").text()
              building   : $course('.building-code').text()
              room       : $course('.class-room').text()
              core       : (c.innerHTML for c in $course '.core-codes-group .course-info-label~a')
              gened      : (g.innerHTML for g in $course '.gen-ed-codes-group .course-subcategory > a')
              seats :
                total    : $sec('.total-seats-count').text()
                open     : $sec('.open-seats-count').text()
                waitlist : $sec('.waitlist-count').text()
              days: (for d in parseDays($course('.section-days').text())
                        day   : d
                        start : $course('.class-start-time').text()
                        end   : $course('.class-end-time'  ).text())

            if 0 < course_data.days.length
              # Only collect courses that have datetime info.
              courses.push course_data

        @emit JSON.stringify courses

@class = CourseScrape
@job = new CourseScrape timeout: 10

