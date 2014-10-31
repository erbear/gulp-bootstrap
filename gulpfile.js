var gulp = require('gulp')
    sass = require('gulp-ruby-sass')
    connect = require('gulp-connect')
    slim = require("gulp-slim");

gulp.task('stylesheets', function() {
  return gulp.src('dist/stylesheets/**/*.sass')
    .pipe(sass({ style: 'expanded' }))
    .pipe(gulp.dest('public/stylesheets'))
    .pipe(connect.reload());
});

gulp.task('templates', function(){
  gulp.src("dist/templates/**/*.slim")
    .pipe(slim({
      pretty: true
    }))
    .pipe(gulp.dest("public/templates"))
    .pipe(connect.reload());
});

gulp.task('webserver', function() {
  connect.server({
    livereload: true
  });
});

gulp.task('watch', function() {

  // Watch .sass files
  gulp.watch('dist/stylesheets/**/*.sass', ['stylesheets']);
  gulp.watch('dist/templates/**/*.slim', ['templates']);

});

gulp.task('default', ['stylesheets', 'templates', 'webserver', 'watch'])