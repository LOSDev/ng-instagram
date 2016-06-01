controllers = angular.module('controllers')

controllers.controller('detailPostCtrl', [
    '$scope', '$rootScope', 'posts', 'post', 'comments', '$state', 'Notification', 'linkify', '$window'
    ($scope, $rootScope, posts, post, comments, $state, Notification, linkify, $window) ->
      $scope.post = post.data
      $scope.comment = {}
      $scope.comments = comments.data.comments
      $scope.comments.total_entries = comments.data.total_entries

      $scope.linkifyDescription = ->
        if $scope.post.description
          linkify.hashTag($scope.post.description)

      $scope.sendDescription = ->
        posts.editDescription($scope.post)
        .then (resp) ->
          Notification.success("Changed Description successfully.")

      $scope.deletePost = (post) ->
        if $window.confirm('Are you sure you want to delete this post?')
          posts.deletePost(post.id)
          .then ->
            Notification.info('Post deleted!')
            $state.go("userDetails", {id: post.user.slug}, {reload: true})
          .catch (response) ->
            Notification.error(response.data.error)


      $scope.loadComments = ->
        page = Math.floor($scope.comments.length / 20) + 1
        posts.getComments($scope.post.id, page)
        .then (resp) ->
          $scope.comments = resp.data.comments.concat($scope.comments)

      $scope.submitComment = ->
        if !$scope.comment.content
          Notification.error("Comment can't be blank")
        else
          posts.createComment($scope.post.id, $scope.comment)
          .then (resp)->
            $scope.comments.push(resp.data)
            $scope.comments.total_entries += 1
            $scope.comment.content = ""
            Notification.success('Comment created!')
          .catch (response) ->
            Notification.error(response.data.error)

      $scope.deleteComment = (comment) ->
        if $window.confirm('Delete this comment?')
          posts.deleteComment($scope.post.id, comment)
          .then ->
            ind = $scope.comments.indexOf(comment)
            $scope.comments.splice(ind, 1)
            $scope.comments.total_entries -= 1
            Notification.info('Comment deleted')
          .catch (response) ->
            Notification.error(response.data.error)

      $scope.checkOwner = (uid) ->
        if $rootScope.currentUser == undefined
          return false
        uid == $rootScope.currentUser.id

      $scope.likePost = ->
        posts.likePost($scope.post.id)
        .then (resp)->
          $scope.post.like = true
          $scope.post.likes +=1
          Notification.success('You like this Post now')
        .catch (response) ->
          Notification.error(response.data.errors.join("\n"))

      $scope.unlikePost = ->
        posts.unlikePost($scope.post.id)
        .then (resp)->
          $scope.post.likes -=1
          $scope.post.like = false
          Notification.info("You don't like this Post anymore")
        .catch (response) ->
          Notification.error(response.data.error)

])
