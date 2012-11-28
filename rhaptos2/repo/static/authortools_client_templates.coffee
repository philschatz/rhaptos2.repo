###
  authoringtools_client_templates.{coffee,js} - Mustache templates for various
    authoring tools interfaces.

  Copyright (c) 2012 Rice University

  This software is subject to the provisions of the GNU Lesser General
  Public License Version 2.1 (LGPL).  See LICENSE.txt for details.
###

# This variable is attached to the window at the very end,
# effectively making it global.
# window.Templates = exports;
exports = {}

exports.IMPORT = '
  <div role="popup-content">
    <input type="hidden" name="id" value="{{id}}">
    <input type="file" name="file">
  </div>'

exports.METADATA = '
  <div role="popup-content" class="span12">
    <form name="metadata-form" action="metadata" method="POST">
      <label>Title</label>
      <input type="text" name="title" value="{{title}}">

      <label>Language</label>
      <select name="language">
      {{#languages}}
        <option value="{{code}}"
                {{#selected}}selected="{{selected}}"{{/selected}}>
          {{native}}
        </option>
      {{/languages}}
      </select>

      <label>Language variant</label>
      <select name="variantLanguage">
      {{#variantLanguages}}
        <option value="{{code}}"
                {{#selected}}selected="{{selected}}"{{/selected}}>
          {{english}}  {{! There is not a `native` value in the variants }}
        </option>
      {{/variantLanguages}}
      </select>

      <label>Subjects</label>
      {{#subjects}}
      <label class="checkbox">
        <input type="checkbox" name="subjects"
               value="{{name}}"
               {{#selected}}checked="checked"{{/selected}}> {{name}}
      </label>
      {{/subjects}}

      <label>Keywords</label>
      <ul id="metadata-keywords" class="tagit">
        {{! This gets populated by the jquery-tagit plugin. }}
      </ul>
    </form>
  </div>'

exports.ROLES_NAME_ENTRY = '
  <tr>
    <td>{{name}}</td>
    {{#roles}}
      <td>
        <input type="checkbox" name="roles" value="{{name}}"
               {{#selected}}checked="checked"{{/selected}}>
      </td>
    {{/roles}}
    <td class="roles-other-actions-column">
      <button type="button" class="btn btn-small role-removal-action"><i class="icon-trash"></i></button>
    </td>
  </tr>'

exports.ROLES_ADD_ENTRY = '
  <tr>
    <td><input type="text" name="name" placeholder="Type a name..."></td>
    {{#roles}}
      <td>
        <input type="checkbox" name="roles" value="{{name}}"
               {{#selected}}checked="checked"{{/selected}}>
      </td>
    {{/roles}}
    <td>
      <button type="button" class="btn btn-small role-add-action"><i class="icon-plus"></i></button>
    </td>
  </tr>'

exports.ROLES = '
  <div role="popup-content">
    <form name="roles-form" action="roles" method="POST">
      <legend>Role Assignments</legend>
      <!-- The role to user listing table -->
      <table class="table table-condensed">
        <thead>
          <tr>
            <th>{{!The name column}}</th>
            {{#roles_vocabulary}}
              <th>{{.}}</th>
            {{/roles_vocabulary}}
            <th><!-- Other actions --></th>
          </tr>
        </thead>
        <tfoot>
        </tfoot>
        <tbody>

        </tbody>
      </table>
    </form>
    <form name="role-entry-form">
      <legend>Add a person to the roles</legend>
      <div class="input-append">
        <input type="text" name="name"
               class="span2"
               placeholder="Type a name...">
        <button type="submit" class="btn"><i class="icon-plus"></i></button>
      </div>
    </form>
  </div>'

exports.SHARING = '
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

exports.PUBLISH = '
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

window.Templates = exports
