###
  Contains the main application logic.

  Author: Michael Mulich
  Copyright (c) 2012 Rice University

  This software is subject to the provisions of the GNU Lesser General
  Public License Version 2.1 (LGPL).  See LICENSE.txt for details.
###

require(['jquery', 'lib/backbone', 'lib/mustache', '!lib/backbone.layoutmanager', '!lib/bootstrap', 'domReady!'], ($, Backbone, Mustache) ->

  console.log('Loaded: main')

  app = {
    root: '/'
    containerId: 'main'
    layouts: {}
    useLayout: (name, type) ->
      # Use a named layout. See also the Backbone.LayoutManager.configure
      #   statement for details about how the layout's are acquired.
      # The layout type corresponds with various layout sections of the page.
      layout = @layouts[type]

      # If already using this layout, then don't reinitialize it.
      if (layout and layout.options.template == name)
        return layout
      # If a layout is active/in-place, deactive/remove it from the DOM.
      if (layout)
        layout.remove()
      # Put the named layout in place.
      console.log("Initializing the '#{name}' layout.")
      layout = new Backbone.Layout({
        template: name
        id: 'layout'
        className: 'layout'
      })
      # Insert into the DOM.
      $("##{@containerId}").empty().append(layout.el)
      layout.render()
      @layouts[type] = layout
      return @layouts[type]
  }

  JST = window.JavaScriptTemplateCache = window.JavaScriptTemplateCache || {}
  Backbone.LayoutManager.configure({
    # XXX Static URL... This sucks because everywhere else can use the
    #     requirejs defined relative paths, but requirejs doesn't expose that
    #     value or how they even got it.
    prefix: '/static/templates/'
    fetch: (path) ->
      path = "#{path}.html"
      if (not JST[path])
        done = @async()
        $.ajax({ url: path, async: false }).then(done)
    render: Mustache.to_html
  })

  class Router extends Backbone.Router
    routes:
      '': 'index'

    index: ->
      # Check for authentication...
      authenticated = false

      layout = undefined
      if (authenticated)
        # Initialize layout workspace
        console.log('User is authenticated')
        app.useLayout('authenticated-layout', 'content')
      else
        # Initialize login
        console.log('User is NOT authenticated')
        app.useLayout('non-authenticated-layout', 'content')

  app.router = new Router()

  # Initialize history for in-place application view routing.
  Backbone.history.start({ pushState: true, root: app.root });

)