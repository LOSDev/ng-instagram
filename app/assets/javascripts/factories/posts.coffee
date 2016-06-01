angular.module('Angstagram')
    .factory('posts', ['$http', ($http) ->

      urlBase = '/posts'
      o = {}

      o.getPosts = ->
        return $http.get(urlBase)

      o.getHashtagPosts = (ht, page=1, order="date") ->
        return $http.get('/hashtag/' + ht + '.json?page=' + page + "&order=" + order)

      o.getPost = (id) ->
        return $http.get(urlBase + '/' + id + '.json')

      o.createPost = (post) ->
        return $http.post(urlBase + '.json', post)

      o.updatePost = (post) ->
        return $http.put(urlBase + '/' + post.ID, post)

      o.editDescription = (post) ->
        return $http.put(urlBase + '/' + post.id + '.json', post)

      o.deletePost = (id) ->
        return $http.delete(urlBase + '/' + id + '.json')

      o.getComments = (id, page) ->
        return $http.get(urlBase + '/' + id + '/comments.json?page=' + page)

      o.createComment = (id, comment) ->
        return $http.post(urlBase + '/' + id + '/comments.json', comment)

      o.deleteComment = (id, comment) ->
        return $http.delete(urlBase + '/' + id + '/comments/' + comment.id + '.json')

      o.getLike = (id) ->
        return $http.get(urlBase + '/' + id + '/like')

      o.likePost = (id) ->
        return $http.post(urlBase + '/' + id + '/likes')

      o.unlikePost = (id) ->
        return $http.delete(urlBase + '/' + id + '/unlike')

      return o
])
