# # Page Controllers
#
# This module sets up page regions (ie header, footer, sidebar, etc),
# route listeners, and updates the URL and DOM with the correct views
#
# This makes it easier in other parts of the code to 'Go back to the Workspace'
# or "Edit this content" when clicking on a link.
define [
  'jquery'
  'backbone'
  'marionette'
  'app/models'
  # There is a cyclic dependency between views and controllers
  # So we use the `exports` module to get around that problem.
  'app/views'
  'hbs!app/layouts/content'
  'hbs!app/layouts/workspace'
  'exports'
  'i18n!app/nls/strings'
], (jQuery, Backbone, Marionette, Models, Views, LAYOUT_CONTENT, LAYOUT_WORKSPACE, exports, __) ->

  # Squirrel away the original contents of the main div (content HTML when viewing the content page for example)
  $main = jQuery('#main')
  $originalContents = $main.contents()
  $main.empty()

  mainRegion = new Marionette.Region
    el: '#main'

  WorkspaceLayout = Marionette.Layout.extend
    template: LAYOUT_WORKSPACE
    regions:
      toolbar:      '#layout-toolbar'
      body:         '#layout-body'
  workspaceLayout = new WorkspaceLayout()


  ContentLayout = Marionette.Layout.extend
    template: LAYOUT_CONTENT
    regions:
      toolbar:      '#layout-toolbar'
      title:        '#layout-title'
      body:         '#layout-body'
      # Specific to content
      metadata:     '#layout-metadata'
      roles:        '#layout-roles'
  contentLayout = new ContentLayout()

  # ## Main Controller
  # Changes all the regions on the page to begin editing a new/existing
  # piece of content.
  #
  # If another part of the code wants to create/edit content
  # it should call these methods instead of changing the URL directly.
  # (depending on the browser the URLs could start with a hash so anchor links won't work)
  #
  # Methods on this object can be called directly and will update the URL.
  mainController =
    # Begin monitoring URL changes and match the current route
    # In here so App can call it once it has completed loading
    start: -> Backbone.history.start()

    getRegion: -> mainRegion

    # ### Show Workspace
    # Shows the workspace listing and updates the URL
    workspace: ->
      # List the workspace
      workspace = new Models.Workspace()
      workspace.fetch()
      view = new Views.WorkspaceView {collection: workspace}
      mainRegion.show workspaceLayout
      workspaceLayout.body.show view
      # Update the URL
      Backbone.history.navigate 'workspace'

      workspace.on 'change', ->
        view.render()

    # ### Create new content
    # Calling this method directly will start editing a new piece of content
    # and will update the URL
    createContent: ->
      content = new Models.Content()
      @_editContent content
      # Update the URL
      Backbone.history.navigate 'content'

    # ### Edit existing content
    # Calling this method directly will start editing an existing piece of content
    # and will update the URL.
    editContent: (id) ->
      content = new Models.Content()
      content.set 'id', id
      # **FIXME:** display a spinner while we fetch the content and then call `@_editContent`
      content.fetch
        error: => alert "Problem getting content #{id}"
        success: =>
          @_editContent content
          # Update the URL
          Backbone.history.navigate "content/#{id}"


    # Internal method that updates the metadata/roles links so they
    # refer to the correct Content Model
    _editContent: (content) ->
      # ## Bind Metadata Dialogs
      mainRegion.show contentLayout

      configAccordionDialog = (region, view) ->
        dialog = new Views.DialogWrapper {view: view}
        region.show dialog
        # When save/cancel are clicked collapse the accordion
        dialog.on 'saved',     => region.$el.parent().collapse 'hide'
        dialog.on 'cancelled', => region.$el.parent().collapse 'hide'

      # Set up the metadata dialog
      configAccordionDialog contentLayout.metadata, new Views.MetadataEditView {model: content}
      configAccordionDialog contentLayout.roles,    new Views.RolesEditView {model: content}

      view = new Views.ContentToolbarView(model: content)
      contentLayout.toolbar.show view

      view = new Views.TitleEditView(model: content)
      contentLayout.title.show view
      # Enable the tooltip letting the user know to edit
      contentLayout.title.$el.popover
        trigger: 'hover'
        placement: 'right'
        content: __('Click to change title')


      view = new Views.ContentEditView(model: content)
      contentLayout.body.show view


  # ## Bind Routes
  ContentRouter = Marionette.AppRouter.extend
    controller: mainController
    appRoutes:
      '':             'workspace' # Show the workspace list of content
      'workspace':    'workspace'
      'content':      'createContent' # Create a new piece of content
      'content/:id':  'editContent' # Edit an existing piece of content

  # Start listening to URL changes
  new ContentRouter()

  # Because of cyclic dependencies we tack on all of the
  # controller methods onto the exported object instead of
  # just returning the controller object
  jQuery.extend(exports, mainController)
