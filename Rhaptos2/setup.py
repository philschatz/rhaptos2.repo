
'''
setup.py for frozone

'''

from distutils.core import setup
import os, glob



def get_scripts():
    files = [os.path.join('scripts', f) for f in  os.listdir('scripts')]
    return files



def main():

    setup(name='Rhaptos2',
          version='0.0.1',
          packages=['rhaptos2'
                    ,'rhaptos2.repo'
                    ,'rhaptos2.libauth'
                    ,'rhaptos2.librhaptos1'
                    ,'rhaptos2.client'
                   ],
          author='See AUTHORS.txt',
          author_email='info@cnx.org',
          url='www.cnx.org',
          license='LICENSE.txt',
          description='New editor / repo / system for cnx.org -frozone.readthedocs.org',
          long_description='see description',
          install_requires=[
              "fabric >= 1.0.0",
              "flask >= 0.8",
              "statsd", "requests"
                           ],
          scripts=get_scripts(),
          )


if __name__ == '__main__':
    main()

