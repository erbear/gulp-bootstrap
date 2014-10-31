var gulp = require('gulp')
    sass = require('gulp-ruby-sass')
    connect = require('gulp-connect');

gulp.task('stylesheets', function() {
  return gulp.src('dist/stylesheets/**/*.sass')
    .pipe(sass({ style: 'expanded' }))
    .pipe(gulp.dest('public/stylesheets'))
    .pipe(connect.reload())
});

gulp.task('webserver', function() {
  connect.server({
    livereload: true
  });
});

gulp.task('watch', function() {

  // Watch .sass files
  gulp.watch('dist/stylesheets/**/*.sass', ['stylesheets']);

});

gulp.task('default', ['stylesheets', 'webserver', 'watch'])