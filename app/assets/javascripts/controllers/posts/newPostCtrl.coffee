controllers = angular.module('controllers')
controllers.controller('postNewCtrl', [
    '$scope', 'posts', '$state', 'Auth', 'Notification', 'Upload',
    ($scope, posts, $state, Auth, Notification, Upload) ->
      $scope.addPost = ->
        if ( $scope.file)
          $scope.upload($scope.file)

      $scope.setFile = (element) ->
        $scope.currentFile = element.files[0]
        reader = new FileReader()

        reader.onload = (event) ->
          $scope.image_source = event.target.result
          $scope.$apply()

        reader.readAsDataURL(element.files[0]);

      $scope.upload = (file) ->
        Upload.upload({
          url: '/posts.json',
          fields: {
            'post[description]': $scope.description,
            'post[image]': $scope.file
          },
          file: file,
          sendFieldsAs: 'json'
        }).then (resp) ->
          $state.go("postDetails",{ id: resp.data.id })
          Notification.success('Post created!')
          $scope.percentage = null
        , (resp) ->
          Notification.error(resp)
          $scope.percentage = null
        , (evt) ->
          $scope.percentage = parseInt(100.0 * evt.loaded / evt.total)
          console.log progressPercentage = parseInt(100.0 * evt.loaded / evt.total);


])
