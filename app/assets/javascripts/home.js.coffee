window.SM ||= {}
App = SM.App = angular.module('App', ['ui.router'])

App.config ["$httpProvider", "$locationProvider", ($httpProvider, $locationProvider) ->
  $locationProvider.html5Mode(true)
  $httpProvider.defaults.headers.common["Accept"] = "application/json"
  $httpProvider.defaults.headers.common["Content-Type"] = "application/json"
]

App.config ["$stateProvider", "$urlRouterProvider", ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise "/"
  $stateProvider.state("/",
    url: "/"
    templateUrl: "hello"
  ).state("batches",
    url: "/batches"
    templateUrl: "batches"
  ).state("user_info",
    url: "/user_info"
    templateUrl: "user_info"
  )
]

App.controller "DateFieldCtrl", ["$scope", "$element", ($scope, $element) ->
]