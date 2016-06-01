angstagram = angular.module('Angstagram', ['ui.router', 'templates',
  'controllers', 'Devise', 'ui-notification', 'ngFileUpload', 'ui.bootstrap'])

angstagram.config(['$stateProvider', '$urlRouterProvider', 'NotificationProvider', '$httpProvider', ($stateProvider, $urlRouterProvider, NotificationProvider, $httpProvider) ->

  $urlRouterProvider.otherwise('/')
  $stateProvider
    .state('home', {
      url: "/"
      templateUrl: 'home.html'
    })
    .state('postNew', {
      url: "/posts/new"
      templateUrl: 'posts/postNew.html'
      controller: 'postNewCtrl'
    })
    .state('postDetails', {
      url: "/posts/:id"
      templateUrl: 'posts/postDetails.html'
      controller: 'detailPostCtrl'
      resolve: {
        post: ['$stateParams', 'posts', ($stateParams, posts) ->
          return posts.getPost($stateParams.id)
        ]
        comments: ['$stateParams', 'posts', ($stateParams, posts) ->
          return posts.getComments($stateParams.id, 1)
        ]
      }
    })

    .state('userFeed', {
      url: "/users/feed"
      templateUrl: 'users/feed.html'
      controller: 'feedCtrl'
      resolve: {
        feed: ['$stateParams', 'users', ($stateParams, users) ->
          return users.getUserFeed(1)
        ]
      }
    })
    .state('userSettings', {
      url: "/users/settings"
      templateUrl: 'devise/settings.html'
      controller: 'userSettingsCtrl'

    })
    .state('userDetails', {
      url: "/users/:id"
      templateUrl: 'users/userDetails.html'
      controller: 'detailUserCtrl'
      resolve: {
        user: ['$stateParams', '$http', ($stateParams, $http) ->
          return $http.get('/users/' + $stateParams.id + '.json')
        ]
        userPosts: ['$stateParams', '$http', ($stateParams, $http) ->
          return $http.get('/users/' + $stateParams.id + '/posts.json')
        ]
      }
    })
    .state('hashtag', {
      url: "/hashtag/:id"
      templateUrl: 'posts/hashtag.html'
      controller: 'hashtagCtrl'
      resolve: {
        loadedPosts: ['$stateParams', 'posts', ($stateParams, posts) ->
          return posts.getHashtagPosts($stateParams.id)
        ]
        hashtag: ['$stateParams', ($stateParams) ->
          return $stateParams.id
        ]
      }
    })
    .state('followers', {
      url: "/users/:id/followers"
      templateUrl: 'users/followers.html'
      controller: 'followersCtrl'
      resolve: {
        followers: ['$stateParams', 'users', ($stateParams, users) ->
          return users.getFollowers($stateParams.id, 1)
        ]
        user: ['$stateParams', 'users', ($stateParams, users) ->
          return users.getUser($stateParams.id)
        ]
      }
    })
    .state('following', {
      url: "/users/:id/following"
      templateUrl: 'users/following.html'
      controller: 'followersCtrl'
      resolve: {
        followers: ['$stateParams', 'users', ($stateParams, users) ->
          return users.getFollowedUsers($stateParams.id, 1)
        ]
        user: ['$stateParams', 'users', ($stateParams, users) ->
          return users.getUser($stateParams.id)
        ]
      }
    })
    .state('likes', {
      url: "/users/:id/likes"
      templateUrl: 'users/likes.html'
      controller: 'userLikesCtrl'
      resolve: {
        likes: ['$stateParams', 'users', ($stateParams, users) ->
          return users.getUserLikes($stateParams.id, 1)
        ]
      }
    })
    .state('login', {
      url: '/login'
      templateUrl: 'devise/login.html'
      controller: 'AuthCtrl'
      onEnter: ['$state', 'Auth', ($state, Auth) ->
        Auth.currentUser().then( ->
          $state.go('userFeed')
        )
      ]
    })
    .state('register', {
      url: '/register'
      templateUrl: 'devise/register.html'
      controller: 'AuthCtrl'
      onEnter: ['$state', 'Auth', ($state, Auth) ->
        Auth.currentUser().then( ->
          $state.go('userFeed')
        )
      ]
    })

  NotificationProvider.setOptions(
    startTop: 50,
    startRight: 10,
    verticalSpacing: 20,
    horizontalSpacing: 20

  )
])
controllers = angular.module('controllers',[])
