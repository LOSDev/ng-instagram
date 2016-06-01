angular.module('Angstagram')
    .factory('users', ['$http', ($http) ->

      urlBase = '/users'
      o = {}

      o.getUsers = ->
        return $http.get(urlBase)

      o.getUserFeed = (page) ->
        return $http.get(urlBase + '/feed.json/?page=' + page)

      o.getUserLikes = (id, page) ->
        return $http.get(urlBase + '/' + id + '/likes.json/?page=' + page)

      o.loadUserPosts = (id, page) ->
        return $http.get('/users/' + id + '/posts.json/?page=' + page)

      o.getFollowers = (id, page) ->
        return $http.get(urlBase + '/' + id + '/followers.json/?page=' + page)

      o.getFollowedUsers = (id, page) ->
        return $http.get(urlBase + '/' + id + '/followed_users.json/?page=' + page)

      o.getUser = (id) ->
        return $http.get(urlBase + '/' + id + '.json')

      o.deleteUser = ->
        return $http.delete(urlBase + ".json")

      o.followUser = (id) ->
        return $http.post(urlBase + '/' + id + '/following_relationships.json')

      o.unfollowUser = (userId, followId) ->
        return $http.delete(urlBase + '/' + userId + '/following_relationships/' + followId + '.json')

      o.getFollowing = (id) ->
        return $http.get(urlBase + "/" + id + '/following.json')

      o.searchUsers = (term) ->
        return $http.get(urlBase + "/search/" + term + '.json')

      return o
])
