angular.module('Angstagram')
    .factory('linkify', ['$sce', ($sce) ->

      o = {}

      o.hashTag = (str) ->
        str = str.replace(/#(\S+)/g,"<a href='#/hashtag/$1' >#$1</a>")
        return $sce.trustAsHtml(str)

      return o
])
