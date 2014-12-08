gulp = require 'gulp'
cson = require 'gulp-cson'
jade = require 'gulp-jade'
styl = require 'gulp-stylus'
coffee = require 'gulp-coffee'

paths =
  cson: 'src/*.cson'
  jade: 'src/*.jade'
  styl: 'src/*.styl'
  coffee: 'src/*.coffee'
  dest: 'build/'

gulp.task 'cson', ->
  gulp.src paths.cson
    .pipe cson()
    .pipe gulp.dest(paths.dest)

gulp.task 'jade', ->
  gulp.src paths.jade
    .pipe jade()
    .pipe gulp.dest(paths.dest)

gulp.task 'styl', ->
  gulp.src paths.styl
    .pipe styl()
    .pipe gulp.dest(paths.dest)

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe coffee()
    .pipe gulp.dest(paths.dest)

gulp.task 'copy', ->
  gulp.src ['lib/Fuse/src/fuse.min.js', 'lib/vue/dist/vue.min.js', 'lib/lodash/dist/lodash.min.js']
    .pipe gulp.dest(paths.dest)

gulp.task 'default', ['cson', 'jade', 'styl', 'coffee', 'copy']
gulp.task 'watch', ['default'], ->
  gulp.watch paths.cson, ['cson']
  gulp.watch paths.jade, ['jade']
  gulp.watch paths.styl, ['styl']
  gulp.watch paths.coffee, ['coffee']
