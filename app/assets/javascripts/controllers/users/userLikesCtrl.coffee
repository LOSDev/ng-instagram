controllers = angular.module('controllers')

controllers.controller('userLikesCtrl', [
  '$scope', 'likes', 'users', '$stateParams', 'posts', 'modalFactory'
  ($scope, likes, users, $stateParams, posts, modalFactory) ->
    $scope.posts = likes.data.posts
    $scope.total_entries = likes.data.total_entries

    $scope.loadLikes = ->
      page = ($scope.posts.length / 12) + 1
      id = $stateParams.id
      users.getUserLikes(id, page)
      .then (resp) ->
        $scope.posts = $scope.posts.concat(resp.data.posts)

    $scope.openModal = (id) ->
      modalInstance = modalFactory.openPost(id)

])
