/**
 * Main entry point for the application configuration and startup.
 *
 * Author: Michael Mulich
 * Copyright (c) 2012 Rice University
 *
 * This software is subject to the provisions of the GNU Lesser General
 * Public License Version 2.1 (LGPL).  See LICENSE.txt for details.
 */

require.config({
    deps: ['main'],
    paths: {
        lib: '../lib',
        /* zepto: '', */
        jquery: '//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery',
        jqueryui: '//ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min',
        // Plugin paths, exception to the rule...
        domReady: '../lib/domReady',
    },
    shim: {
        'lib/backbone': {
            /* deps: ['jquery', 'lodash'], */
            deps: ['jquery', 'lib/underscore'],
            exports: 'Backbone',
        },
        'lib/bootstrap': {
            deps: ['jquery'],
            exports: 'bootstrap',
        },
    },
})
