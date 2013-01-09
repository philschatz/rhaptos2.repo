#!/usr/bin/env python
#! -*- coding: utf-8 -*-

###  
# Copyright (c) Rice University 2012
# This software is subject to
# the provisions of the GNU Lesser General
# Public License Version 2.1 (LGPL).
# See LICENCE.txt for details.
###


import sys


# Simple python version test                                                  
major,minor = sys.version_info[:2]
py_version = sys.version.split()[0]
if major != 2 or minor < 7:
  print "You are using python %s, but \
version 2.7 or greater is required" % py_version
  raise SystemExit(1)



