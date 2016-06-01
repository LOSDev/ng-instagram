controllers = angular.module('controllers')
controllers.controller('NavCtrl',
  ['$scope', '$rootScope', 'Auth', 'Notification', 'users', '$state', 'Upload'
  ($scope, $rootScope, Auth, Notification, users, $state, Upload) ->
    $rootScope.currentUser = false
    $scope.isCollapsed = false
    Auth.currentUser().then (user) ->
      $scope.user = user

    $scope.signedIn = Auth.isAuthenticated

    $scope.logout = ->
      Auth.logout().then (resp) ->


    $scope.query = ''
    $scope.users = []
    $scope.getUsers = (query) ->
      users.searchUsers(query)
      .then (resp) ->
        $scope.users = resp.data

    $scope.selectUser = ($item, $model, $label) ->
      $state.go("userDetails", id: $model._source.slug)
      $scope.query = ''

    $scope.upload = (file) ->
      Upload.upload({
        url: '/posts.json',
        fields: {
          'post[image]': $scope.file
        },
        file: file,
        sendFieldsAs: 'json'
      }).then (resp) ->
        $state.go("postDetails",{ id: resp.data.id })
        Notification.success('Post created!')
        Notification.info('Add a Description to your Post.')
        $scope.percentage = null
        $scope.file = null

      , (resp) ->
        Notification.error(resp)
        $scope.percentage = null
        $scope.file = null

      , (evt) ->
        $scope.percentage = parseInt(100.0 * evt.loaded / evt.total)
        console.log progressPercentage = parseInt(100.0 * evt.loaded / evt.total);


    $scope.$on('devise:new-registration', (e, user) ->
      $scope.user = user
      Notification.success("Registration successful!")
      $rootScope.currentUser = Auth._currentUser
    )
    $scope.$on('devise:login', (e, user) ->
      $scope.user = user
      Notification.success("You are logged in!")
      $rootScope.currentUser = Auth._currentUser
    )
    $scope.$on('devise:logout', (e, user) ->

      $scope.isOpen = false
      $scope.user = {}
      Notification.success("You are logged out now.")
      $rootScope.currentUser = false
    )
])
