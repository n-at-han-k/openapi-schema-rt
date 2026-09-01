# Request Tracker Openapi

Request Tracker's API documentation is garbage. This is a reverse engineered [OpenAPI](https://spec.openapis.org/oas/latest.html) spec to make up for it.


## Completeness

Not even close. I've been adding paths as I need them.


## License

SPDX-License-Identifier: LGPL-2.0-or-later


# Development

Written with [Insomnium](https://archgpt.dev/insomnium).


## Contributing

Want to help make this better? Feedback and patches are welcome!


## Testing

There's no automated testing ATM, mainly due the lack of OAS 3.1 compatible tools.
However you can verify your requests locally with [wiretap](https://pb33f.io/wiretap/):

To start wiretap in a container run the following in this directory:
```bash
$ podman run --rm --publish 9090:9090 --publish 9091:9091 --publish 9092:9092 --volume $PWD:/work:rw pb33f/wiretap --spec request_tracker_rest2.yaml --url https://host.containers.internal
```
The above assumes that your test RT server is running on localhost, but you can also change the URL.
Then just make your requests with Insomnium (or curl or whatever) to `localhost:9090`, and wiretap will make sure that they conform to the spec.
