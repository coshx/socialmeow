window.SM ||= {}
App = SM.App = angular.module('App', ['ui.router', 'restangular'])

App.config ["$httpProvider", "$locationProvider", ($httpProvider, $locationProvider) ->
  $locationProvider.html5Mode(true)
  $httpProvider.defaults.headers.common["Accept"] = "application/json"
  $httpProvider.defaults.headers.common["Content-Type"] = "application/json"
]

App.config ["$stateProvider", "$urlRouterProvider", "RestangularProvider", ($stateProvider, $urlRouterProvider, RestangularProvider) ->
  RestangularProvider.setBaseUrl '/api/'
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
  ).state("user_mine",
    url: "/mine"
    templateUrl: "user_mine"
  )
]

App.controller "UserMineCtrl", ["$scope", "$element", "Restangular", ($scope, $element, Restangular) ->
  credentials = Restangular.one('users', 123).getList('accounts').then (result) ->
    $scope.accounts = result
    console.log result
  $scope.mine = ->
    Restangular.one('users', 123).post('mines', {accounts: _.where($scope.accounts, {selected: true})})
  $scope.selectedUsers = ->
    _.map(_.where($scope.accounts, {selected: true}), (account) -> account.handle;)
]

App.controller "UserInfoCtrl", ["$scope", "$element", "Restangular", ($scope, $element, Restangular) ->
  credentials = Restangular.one('users', 123).getList('credentials').then (result) ->
    $scope.credentials = result[0]
  $scope.submit = (credentials) ->
    a = Restangular.one('users', 123).post('credentials', {credentials: credentials})
]