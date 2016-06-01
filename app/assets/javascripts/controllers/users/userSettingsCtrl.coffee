controllers = angular.module('controllers')

controllers.controller('userSettingsCtrl', [
  '$scope', 'users', '$state', 'Auth', 'Upload', 'Notification', '$window',
  ($scope, users, $state, Auth, Upload, Notification, $window) ->
    Auth.currentUser()
    .then (user) ->
      $scope.user = user
      users.getUser(user.id)
      .then (resp) ->
        $scope.image_source = resp.data.avatar.medium.url

    $scope.deleteAccount = ->
      if $window.confirm('Are you sure you want to delete your Account?')
        users.deleteUser()
        .then (resp) ->
          Auth.logout().then (resp) ->
            
          Notification.info("Your Account has been deleted.")
          $state.go("home")


    $scope.editSettings = ->
      $scope.upload($scope.user.avatar)

    $scope.setFile = (element) ->
      $scope.currentFile = element.files[0]
      reader = new FileReader()

      reader.onload =(event) ->
        $scope.image_source = event.target.result
        $scope.$apply()

      reader.readAsDataURL(element.files[0]);

    $scope.upload = (file) ->
      Upload.upload({
        url: '/users.json',
        fields: {
          'user[email]': $scope.user.email,
          'user[password]': $scope.user.password,
          'user[password_confirmation]': $scope.user.password_confirmation,
          'user[current_password]': $scope.user.current_password,
          'user[username]': $scope.user.username,
          'user[bio]': $scope.user.bio,

          'user[avatar]': file
        },
        file: file,
        method: 'PUT'
        sendFieldsAs: 'json'
      }).then (resp) ->
        Notification.success('Account updated successfully!')
        $state.go("userDetails",{ id: $scope.user.username })
      , (resp) ->
        $scope.errors = resp.data.errors
        Notification.error("Please fix the errors to update your Profile.")
      , (evt) ->
          console.log progressPercentage = parseInt(100.0 * evt.loaded / evt.total);

])
