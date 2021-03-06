/**
 * Used to initialize the Aloha settings for this application.
 *
 * Author: Michael Mulich
 * Copyright (c) 2012 Rice University
 *
 * This software is subject to the provisions of the GNU Lesser General
 * Public License Version 2.1 (LGPL).  See LICENSE.txt for details.
 */

/* Aloha = window.Aloha || {};

Aloha.settings = {
    // jQuery: window.jQuery,
    // logLevels: {'error': true, 'warn': true, 'info': false, 'debug': false},
    // errorhandling : true,
    plugins: {
        image: {
            uploadurl: "/resource",
            parseresponse: function(xhr) { return xhr.response; },
        },
        block: {
            defaults : {
                '.default-block': {
                },
                'figure': {
                    'aloha-block-type': 'EditableImageBlock'
                },
            }
        }
    },
};



	<script type="text/javascript">
*/
		Aloha = window.Aloha || {};

		Aloha.settings = {
			jQuery: window.jQuery,
			logLevels: {'error': true, 'warn': true, 'info': false, 'debug': false},
			errorhandling : true,

			plugins: {
			  // This whole thing is what's needed to:
			  // - set a custom URL to send files to
			  // - register a callback that updates the IMG with the new src
			  draganddropfiles: {
          upload: {
            config: {
              method: 'POST',
              url: '/resource',
              fieldName: 'upload',
              send_multipart_form: true,
              callback: function(resp) {
                //TODO: add xhr to Aloha.trigger('aloha-upload-*') in dropfilesrepository.js
                // dropfilesrepository.js triggers 'aloha-upload-success'
                // and 'aloha-upload-failure' but does not provide the
                // response text (URL).
                // We should probably change dropfilesrepository.js to be
                //  Aloha.trigger('aloha-upload-success', that, xhr);

                // Then, instead of configuring a callback we could just listen to that event

                // If the response is a URL then change the Image source to it
                // The URL could be absolute (/^http/) or relative (/\// or [a-z])
                // alert('posted file: ' + resp);
                if (resp.match(/^http/) || resp.match(/^\//) || resp.match(/^[a-z]/) ) {
                } else {
                  alert('You dropped a file and we sent a message to the server to do something with it.\nIt responded with some gibberish so we are showing you some other file to show it worked');
                  resp = "src/test/AlohaEditorLogo.png";
                }

                /* Drag and Drop creates an <img id="{this.id}"> element but the
                 * "New Image" plugin doesn't have access to the UploadFile object (this)
                 * so all it can do is add a class.
                 * If I combine both then we can set the attribute consistently.
                 * FIXME: Don't assume only 1 image can be uploaded at a time
                 */
                $img = Aloha.jQuery('.aloha-image-uploading').add('#' + this.id);
                $img.attr('src', resp);
                $img.removeClass('aloha-image-uploading');
                console.log('Updated Image src as a result of upload');
              }
            }
          }
			  },
				block: {
					defaults : {
						'.default-block': {
						},
						'figure': {
							'aloha-block-type': 'EditableImageBlock'
						},
					}
				}
			}
		};

/*	</script> */
