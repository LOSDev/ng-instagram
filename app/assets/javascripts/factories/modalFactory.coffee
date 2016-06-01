angular.module('Angstagram')
    .factory('modalFactory', ['$uibModal', 'posts', ($uibModal, posts) ->

      return {
        openPost: (id, template) ->
          return $uibModal.open({
            animation: true,
            templateUrl: template || 'posts/_postModal.html',
            controller: 'postModalInstanceCtrl',
            size: 'lg',
            resolve: {
              post: ->
                return posts.getPost(id)
              comments: ->
                return posts.getComments(id, 1)
            }
          })
      }
])
