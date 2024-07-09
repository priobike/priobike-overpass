# priobike-overpass

We use this repository to build our own [Overpass](https://github.com/drolbr/Overpass-API) image. It is configurable, what OSM file is used. Through this, it is possible for our PrioBike project, to build separate images for both map data foundations (OSM and OSM-DRN).

This service is built in such a way that it takes the OSM file from an existing image. Therefore, we need an image where a ready-to-use OSM file is stored. In our projekt, we use the GraphHopper images for this purpose.

[Learn more about PrioBike](https://github.com/priobike)

## Quickstart

Run using Docker:
```bash
docker build -t priobike-overpass . && docker run -p 80:80 --rm priobike-overpass
```

Via the following build arguments, the build can be configured:
- `BASE_IMAGE`: Which image should be used as a base image. In the image has to be an OSM file.
- `OSM_FILE_PATH`: Where is the OSM file located in the base image.
- `OVERPASS_PLANET_PREPROCESS`: What commands should be executed as a preprocessing step. Depending on the format of the OSM file it may need to be converted to be used by Overpass. More information about this can be found in the [Overpass documentation](https://github.com/wiktorn/Overpass-API?tab=readme-ov-file#how-to-use-this-image). You might also want to take a look at the `.github/workflows` files to find out how we build our images.

## Contributing

We highly encourage you to open an issue or a pull request. You can also use our repository freely with the `MIT` license. 

Every service runs through testing before it is deployed in our release setup. Read more in our [PrioBike deployment readme](https://github.com/priobike/.github/blob/main/wiki/deployment.md) to understand how specific branches/tags are deployed.

## Anything unclear?

Help us improve this documentation. If you have any problems or unclarities, feel free to open an issue.