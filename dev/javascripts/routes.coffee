angular.module('SampleApp').config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/');

  $stateProvider
  .state('home', {
    url: '/',
    controller: 'HomeCtrl',
    templateUrl: 'assets/templates/home.html'
  })

