

import httplib
import urllib


def sendajax(datadict, tgturl, method='POST'):

    ''' send as ajax (json?) a payload to a tgturl, and return the response 
     
    this is a throwaway stub for a full featured library that is needed, inlcuding netowrk failure handling etc

    '''

    params = urllib.urlencode(datadict)
    # adjust headers etc.  Need finer control
    dt = urllib.urlopen(tgturl, params).read()  



    return dt


     
if __name__ == '__main__':
#    print sendajax({'moduletxt': '<P>this is text</p>'}, 'http://e2server.office.mikadosoftware.com/e2server/module/')
    print sendajax({'moduletxt': '<P>this is text</p>'}, 'http://cnx1:5000/module/')

