controllers = angular.module('controllers')
controllers.controller('postModalInstanceCtrl',
  ['$scope', '$controller', '$rootScope', 'post', 'posts', 'comments', '$uibModalInstance', 'linkify', 'Notification',
  ($scope, $controller, $rootScope, post, posts, comments, $uibModalInstance, linkify, Notification) ->
    $controller('detailPostCtrl', {$scope: $scope, post: post, comments: comments})

    $scope.loadPost = (id) ->
      posts.getPost(id)
      .then (resp) ->
        $scope.post = resp.data
        posts.getComments(id, 1)
      .then (resp) ->
        $scope.comments = resp.data.comments
        $scope.comments.total_entries = resp.data.total_entries

    $scope.$on("$locationChangeStart", (event, next, current) ->
      $uibModalInstance.dismiss('cancel')
    )
])
