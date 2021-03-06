###
  authoringtools_client_templates.{coffee,js} - Mustache templates for various
    authoring tools interfaces.

  Copyright (c) 2012 Rice University

  This software is subject to the provisions of the GNU Lesser General
  Public License Version 2.1 (LGPL).  See LICENSE.txt for details.
###

define ['mustache'], (Mustache) ->
  # Export the templates so they can be used by other modules
  templates = {}

  templates.IMPORT = '
    <div role="popup-content">
      <input type="hidden" name="id" value="{{id}}">
      <input type="file" name="file">
    </div>'

  # FIXME: Convert these into compiled templates
  templates.METADATA = Mustache.compile '
    <label>Title</label>
    <input required type="text" name="title" value="{{title}}">

    <label>Language</label>
    <select required name="language">
    {{#_languages}}
      <option value="{{code}}">
        {{native}}
      </option>
    {{/_languages}}
    </select>

    <label for="variantLanguage">Language variant</label>
    <select name="variantLanguage"></select>

    <label>Subjects</label>
    {{#_subjects}}
    <label class="checkbox">
      <input type="checkbox" name="subjects" value="{{.}}"/> {{.}}
    </label>
    {{/_subjects}}

    <label>Keywords</label>
    <ul id="metadata-keywords" class="tagit">
      {{#keywords}}
        <li>{{.}}</li>
      {{/keywords}}
    </ul>'

  templates.LANGUAGE_VARIANTS = Mustache.compile '<option value="">None</option>{{#variants}}<option value="{{code}}">{{english}}</option>{{/variants}}'

  templates.ROLES = Mustache.compile '
    <h3>Role Assignments</h3>
    <h4>Authors</h4>
    <ul class="authors">
      {{#authors}}
      <li>{{.}}</li>
      {{/authors}}
    </ul>
    <h4>Copyright Holders</h4>
    <ul class="copyright-holders">
      {{#copyrightHolders}}
      <li>{{.}}</li>
      {{/copyrightHolders}}
    </ul>'

  templates.MODAL_WRAPPER = Mustache.compile '
    <div class="modal hide fade in">
      <form name="modal-form">
        <div class="modal-header">
          <button type="button" class="close"
                  data-dismiss="modal" aria-hidden="true">×</button>
          <h3 id="modal-header-label">{{title}}</h3>
        </div>
        <div class="modal-body"></div>
        <div class="modal-footer">
          <button type="submit" class="save btn btn-primary">Save</button>
          <button type="button" class="cancel btn" data-dismiss="modal">Cancel</button>
        </div>
      </form>
    </div>'

  templates.SHARING = '
    <div role="popup-content">
      <form name="sharing-form" action="sharing" method="POST">
        <legend>Sharing Assignments</legend>
        <!-- The role to user listing table -->
        <table class="table table-condensed">
          <thead>
            <tr>
              <th></th>
              <th>Owner</th>
              <th>Editor</th>
              <th>Reviewer</th>
              <th><!-- Other actions --></th>
            </tr>
          </thead>
          <tfoot>
          </tfoot>
          <tbody>
            <tr>
              <th>Michael</th>
              <td><input type="checkbox" name="role" value="uid"></td>
              <td>
                <button type="button"
                        class="btn btn-danger btn-mini">remove</button>
              </td>
            </tr>
            <tr>
              <th>Ross</th>
              <td><input type="checkbox" name="role" value="uid"></td>
              <td><input type="checkbox" name="role" value="uid"></td>
              <td>
                <button type="button"
                        class="btn btn-danger btn-mini">remove</button>
              </td>
            </tr>
          </tbody>
        </table>
      </form>
      <form name="sharing-search-form">
        <legend>Search for people</legend>

        <div id="sharing-search-form-results">
          <!-- A search for the letter "a" -->
          <span class="user-result badge badge-info" data-uid="uid">Isabel</span>
          <!-- Michael shows up in the search results but is disabled --
            -- since he is already in the list. -->
          <span class="user-result badge" data-uid="uid">Michael</span>
          <span class="user-result badge badge-info" data-uid="uid">Paul</span>
        </div>

        <div class="input-append">
          <input type="text" name="q"
                 class="span2"
                 placeholder="Type a name...">
          <button type="submit" class="btn">Search</button>
        </div>
      </form>
    </div>'

  templates.PUBLISH = '
    <div role="popup-content">
      <form name="publish-form" action="publish" method="POST">
        <legend>Description of the changes</legend>
        <input type="text" name="change_description"
               class="span4"
               placeholder="Description of the change...">
        <legend>License</legend
        <div>
          <p>This work will now be distributed under the terms of the Creative Commons Attribution License (<span>CC-BY 3.0</span>) available at <a style="font-style: italic" href="http://creativecommons.org/licenses/by/3.0/">http://creativecommons.org/licenses/by/3.0/</a>.
          </p>
          <p>By publishing this content you area to the following statement: I understand that in doing so I</p>
          <ol>
            <li>retain my copyright in the work and</li>
            <li>warrant that I am the author or the owner or have permission to distribute the work in question and</li>
            <li>wish this work to be distributed under the terms of the CC-BY 3.0 license (including allowing modification of this work and requiring attribution) and</li>
            <li>agree that proper attribution of my work is any attribution that includes the authors\' names, the title of the work, and the Connexions URL to the work.</li>
          </ol>
        </div>
      </form>
    </div>'

  # Export the templates so they can be used by other modules
  return templates
