controllers = angular.module('controllers')

controllers.controller('followersCtrl', [
  '$scope', 'followers', 'user', '$state', 'users',
  ($scope, followers, user, $state, users) ->
    $scope.user = user.data
    $scope.followers = followers.data

    $scope.getFollowers = ->
      page = ($scope.followers.length / 20) + 1
      users.getFollowers($scope.user.id, page)
      .then (resp) ->
        $scope.followers = $scope.followers.concat(resp.data)

    $scope.getFollowedUsers = ->
      page = ($scope.followers.length / 20) + 1
      users.getFollowedUsers($scope.user.id, page)
      .then (resp) ->
        $scope.followers = $scope.followers.concat(resp.data)

])
