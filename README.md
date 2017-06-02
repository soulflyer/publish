# publish

publish takes care of creating smaller watermarked copies of images.
It should automatically detect when an image is newer than it's published versions and recreate them.

## versions.sh

    version.sh image1 [image2 image3 ....]

If the fullsize version of an image is newer than the medium version then the small medium large and thumb sized versions are re-created from the fullsize version. The images can be given as a full or partial path. The locations of the various versions are set in the file: setup.sh . They will also be read from the command line (Not yet implemented).
