var gulp = require('gulp')
    sass = require('gulp-ruby-sass')

gulp.task('stylesheets', function() {
  return gulp.src('dist/stylesheets/**/*.sass')
    .pipe(sass({ style: 'expanded' }))
    .pipe(gulp.dest('public/stylesheets'))
    .pipe(notify({ message: 'Styles task complete' }));
});