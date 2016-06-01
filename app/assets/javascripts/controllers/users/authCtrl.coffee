controllers = angular.module('controllers')
controllers.controller('AuthCtrl', [
  '$scope', '$state', 'Auth', 'Upload', 'Notification',
  ($scope, $state, Auth, Upload, Notification) ->

    $scope.login = ->
      Auth.login($scope.user)
      .then (resp) ->
        $state.go('home')
      .catch (resp) ->
        Notification.error("Invalid email or password.")

    $scope.signedIn = Auth.isAuthenticated

    $scope.setFile = (element) ->
      $scope.currentFile = element.files[0]
      reader = new FileReader()

      reader.onload =(event) ->
        $scope.image_source = event.target.result
        $scope.$apply()

      reader.readAsDataURL(element.files[0]);

    $scope.register = ->
      $scope.upload($scope.user.avatar)
    $scope.upload = (file) ->
      Upload.upload({
        url: '/users.json',
        fields: {
          'user[email]': $scope.user.email,
          'user[password]': $scope.user.password,
          'user[username]': $scope.user.username,
          'user[bio]': $scope.user.bio,
          'user[avatar]': file
        },
        file: file,
        sendFieldsAs: 'json'
      }).then (resp) ->
        Notification.success('Registration successful!')
        Auth.login(resp.data)
        $state.go("userDetails",{ id: resp.data.id })
      , (resp) ->
        $scope.errors = resp.data.errors
        Notification.error("Please fix the errors to create your Profile.")
      , (evt) ->
          console.log progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
])
