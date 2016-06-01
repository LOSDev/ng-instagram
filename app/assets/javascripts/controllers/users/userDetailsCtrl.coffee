controllers = angular.module('controllers')

controllers.controller('detailUserCtrl', [
  '$scope', '$rootScope', 'users', 'user', 'userPosts', '$state', 'Notification', 'posts', 'linkify', 'Auth', 'modalFactory',
  ($scope, $rootScope, users, user, userPosts, $state, Notification, posts, linkify, Auth, modalFactory) ->
    $scope.user = user.data
    $scope.total_entries = user.data.total_entries
    $scope.posts = userPosts.data

    $scope.loggedIn = ->
      if !Auth.isAuthenticated()
        Notification.error("Please log in.")
        return false
      return true

    $scope.loadUserPosts = ->
      page = ($scope.posts.length / 12) + 1
      users.loadUserPosts($scope.user.slug, page)
      .then (resp) ->
        $scope.posts = $scope.posts.concat(resp.data)


    $scope.openModal = (id) ->
      modalInstance = modalFactory.openPost(id)

    $scope.following = ->
      users.getFollowing($scope.user.id)
      .then (resp) ->
        $scope.followingThisUser = resp.data
      .catch (resp) ->
        $scope.followingThisUser = false


    $scope.followUser = ->
      if $scope.loggedIn()
        users.followUser($scope.user.slug)
        .then (resp) ->
          $scope.user.followers += 1
          $scope.followingThisUser = resp.data
          Notification.success("You are now following: " + $scope.user.username )
        .catch (resp) ->
          Notification.error(resp.data.errors.join('\n'))

    $scope.unfollowUser = ->
      users.unfollowUser($scope.user.slug, $scope.followingThisUser.id)
      .then (resp) ->
        $scope.user.followers -= 1
        $scope.followingThisUser = undefined
        Notification.info("You are not following " + $scope.user.username + " anymore.")

    $scope.followingThisUser = $scope.following()
])
