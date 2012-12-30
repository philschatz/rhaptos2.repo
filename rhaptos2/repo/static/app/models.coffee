define ['backbone'], (Backbone) ->
  exports = exports or {}

  # Default language for new content is the browser's language
  browserLanguage = (navigator.userLanguage or navigator.language or '').toLowerCase() if navigator

  # This model contains the following members:
  #
  # * `title` - a text title of the module
  # * `language` - the main language (eg `en-us`)
  # * `subjects` - an array of strings (eg `['Mathematics', 'Business']`)
  # * `keywords` - an array of keywords (eg `['constant', 'boltzmann constant']`)
  # * `authors` - an `Collection` of `User`s that are attributed as authors
  exports.Module = Backbone.Model.extend
    defaults:
      language: browserLanguage
    url: ->
      @get 'url'

  exports.Workspace = Backbone.Model.extend
    url: '/workspace/'

  return exports