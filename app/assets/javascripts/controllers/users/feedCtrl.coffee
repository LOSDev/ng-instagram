controllers = angular.module('controllers')

controllers.controller('feedCtrl', [
  '$scope', 'feed', 'users', 'posts', 'modalFactory',
  ($scope, feed, users, posts, modalFactory) ->
    $scope.posts = feed.data.posts
    $scope.total_entries = feed.data.total_entries

    $scope.loadFeed = ->
      page = ($scope.posts.length / 12) + 1
      users.getUserFeed(page)
      .then (resp) ->
        $scope.posts = $scope.posts.concat(resp.data.posts)

    $scope.openModal = (id) ->
      modalInstance = modalFactory.openPost(id)

])
