#!/usr/bin/python
# Usage: python opencvDetector.py <method> <pathDataset>
# Ex: python opencvDetector.py SIFT /path/to/repository/benchmark-orientation/data/Viewpoints

import sys
import os

if len(sys.argv) < 3:
    print 'Error, missing arguments'
    print 'Usage: python opencvDetector.py <method> <pathDataset>'
    print 'Ex: python opencvDetector.py SIFT /path/to/repository/benchmark-orientation/data/Viewpoints\n'
    exit(1)

program = 'opencvDetector'

method = sys.argv[1]
pathDataset = sys.argv[2]

dirImgs = 'test/image_color'
dirOut = 'test/features'

ext = '.png'
#ext = '.jpg'


nameFileOut = '_' + method + '_keypoints-none-txt'

for dir in os.listdir(pathDataset):

    if os.path.isdir(pathDataset + '/' + dir):
        pathImages = pathDataset + '/' + dir + '/' + dirImgs

        for image in os.listdir(pathImages):
            if os.path.isfile(pathImages + '/' + image):
                pathImg = pathImages + '/' + image
                nameImg = image[0:image.find(ext)]
                pathFileOut = pathDataset + '/' + dir + '/' + dirOut + '/' + nameImg + nameFileOut
                print program + ' ' + method + ' ' + pathImg + ' ' + pathFileOut + '\n'
                # raw_input('paused')
                status = os.system('./' + program + ' ' + method + ' ' + pathImg + ' ' + pathFileOut)
                if status != 0:
                    print 'Error - status', status
                    exit(1)

