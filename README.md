# publish

publish takes care of creating smaller watermarked copies of images.
It should automatically detect when an image is newer than it's published versions and recreate them.

## versions

    version image1 [image2 image3 ....]

If the fullsize version of an image is newer than the medium version then the small medium large and thumb sized versions are re-created from the fullsize version. The images can be given as a full or partial path. The locations of the various versions are set in the file: setup.sh . They will also be read from the command line (Not yet implemented).

## make-gif

Takes a series of images and turns them into an animated gif. Can take a list of pictures or a directory containing only the images to be converted to a gif. This is specified with the -f option.

-o will specify where the output goes. 

-t will specify where the thumbnail goes. Defaults to <output folder>/thumbs

-p specifies a project and creates versions of the gif in each of the thumbs, small, medium and large directories for that project, as well as sending the default gif to the fullsize folder.

