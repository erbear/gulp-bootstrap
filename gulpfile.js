var gulp = require('gulp')
    sass = require('gulp-ruby-sass')
    connect = require('gulp-connect')
    slim = require("gulp-slim")
    concat = require("gulp-concat")
    insert = require("gulp-insert")
    bowerFiles = require('main-bower-files'),
    inject = require('gulp-inject'),
    coffee = require("gulp-coffee");

gulp.task('stylesheets', function() {
  return gulp.src('dev/stylesheets/**/*.sass')
    .pipe(sass({ style: 'expanded' }))
    .pipe(concat('application.css'))
    .pipe(gulp.dest('assets/stylesheets'))
    .pipe(connect.reload());
});

gulp.task('templates', function(){
  gulp.src("dev/templates/**/*.slim")
    .pipe(slim({
      pretty: true,
      options: "attr_delims={'(' => ')', '[' => ']'}"
    }))
    .pipe(gulp.dest("assets/templates"))
    .pipe(connect.reload());
});

gulp.task('javascripts', function() {
  gulp.src('dev/javascripts/**/*.coffee')
    .pipe(coffee({bare: true}))
    .pipe(concat("application.js"))
    .pipe(gulp.dest('assets/javascripts'))
    .pipe(connect.reload());
});

gulp.task('index', function(){
  gulp.src("dev/index.slim")
    .pipe(slim({
      pretty: true,
      options: "attr_delims={'(' => ')', '[' => ']'}"
    }))
    .pipe(gulp.dest("assets"))
    .pipe(connect.reload());
});


gulp.task('webserver', function() {
  connect.server({
    livereload: true
  });
});

gulp.task('inject', function() {
  var application = gulp.src(['assets/**/*.js', 'assets/**/*.css'])
  gulp.src('assets/index.html')
  .pipe(inject(gulp.src(bowerFiles(), {read: false}), {name: 'bower'}))
  .pipe(inject(application, {name: 'application'}))
  .pipe(gulp.dest(""));
});

gulp.task('watch', function() {

  // Watch .sass files
  gulp.watch('dev/stylesheets/**/*.sass', ['stylesheets']);
  gulp.watch('dev/templates/**/*.slim', ['templates']);
  gulp.watch('dev/index.slim', ['index']);
  gulp.watch('assets/index.html', ['inject']);
  gulp.watch('dev/javascripts/**/*.coffee', ['javascripts']);

});

gulp.task('default', ['stylesheets', 'templates', 'index', 'inject', 'javascripts', 'webserver', 'watch'])