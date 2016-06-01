controllers = angular.module('controllers')

controllers.controller('hashtagCtrl',
  ['$scope', 'loadedPosts', 'hashtag', '$uibModal', 'posts', 'modalFactory',
  ($scope, loadedPosts, hashtag, $uibModal, posts, modalFactory) ->
    $scope.posts = loadedPosts.data.posts
    $scope.total_entries = loadedPosts.data.total_entries
    $scope.hashtag = hashtag
    $scope.order = 'date'

    $scope.changeOrder = (order) ->
      posts.getHashtagPosts($scope.hashtag, 1, order)
      .then (resp) ->
        $scope.posts = resp.data.posts
        $scope.order = order


    $scope.loadHashtagPosts = () ->
      page = Math.floor($scope.posts.length / 12) + 1
      posts.getHashtagPosts($scope.hashtag, page, $scope.order)
      .then (resp) ->
        $scope.posts = $scope.posts.concat(resp.data.posts)

    $scope.openModal = (id) ->
      modalInstance = modalFactory.openPost(id)
])
