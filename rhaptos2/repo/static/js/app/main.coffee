###
  Contains the main application logic.

  Author: Michael Mulich
  Copyright (c) 2012 Rice University

  This software is subject to the provisions of the GNU Lesser General
  Public License Version 2.1 (LGPL).  See LICENSE.txt for details.
###

require(['jquery', 'lib/backbone', 'lib/underscore', '!lib/bootstrap'], ($, Backbone, _) ->

  console.log('loaded: main')

  app = {root: '/'}

  class Router extends Backbone.Router
    routes:
      '': 'index'

    index: ->
      # Check for authentication...
      authenticated = false

      if (authenticated)
        # Initialize layout workspace
        console.log('user is authenticated')
      else
        # Initialize login
        console.log('user is NOT authenticated')

  app.router = new Router()

  # Initialize history for in-place application view routing.
  Backbone.history.start({ pushState: true, root: app.root });

)