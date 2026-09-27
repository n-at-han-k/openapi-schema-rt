# Request Tracker Openapi

Request Tracker's API documentation is garbage. This is a reverse engineered [OpenAPI](https://spec.openapis.org/oas/latest.html) spec to make up for it.


## This is a fork

Upstream is [rt/request-tracker-openapi](https://gitlab-ext.utu.fi/rt/request-tracker-openapi)
at UTU, and its history is this repo's history. The fork exists to describe
the rest of the REST2 surface, because [crossplane-provider-rt] is generated
from this document and can only manage what the document describes.

The additions follow upstream's conventions and keep its file name, so they
can be sent back as a patch. Nothing upstream wrote has been changed.


## Completeness

Upstream's own answer was "not even close. I've been adding paths as I need
them." As of 0.3.0 this fork describes 71 paths and 103 operations:

| Object | Operations |
|---|---|
| Ticket | create, read, update, delete, search |
| Queue | create, read, update, delete, list |
| User | create, read, update, delete, search, memberships |
| Group | create, read, update, delete, search, members |
| Custom field | create, read, update, delete, search, **values (CRUD)** |
| **Catalog** | create, read, update, delete, list |
| **Class** | create, read, update, delete, list |
| **Asset** | create, read, update, delete, search |
| **Article** | create, read, update, delete, search |
| **Custom role** | read, search |
| **Lifecycle** | create, read, update, delete, list, maps, validate |
| **Rights** | list, grant, revoke, bulk, available — on queue, group, class, catalog, custom field and global |

Bold is what this fork added. Field sets come from the endpoints documented at
[RT::REST2] and the `Create()` arguments each RT class documents.

Still not described: the ticket action endpoints (`take`, `untake`, `steal`,
`comment`, `correspond`, `merge`, the `bulk` variants), transactions,
attachments, history and saved searches. Those are verbs and read-only
reports rather than objects with a lifecycle.

[crossplane-provider-rt]: https://github.com/n-at-han-k/crossplane-provider-rt
[RT::REST2]: https://docs.bestpractical.com/rt/latest/RT/REST2.html


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
