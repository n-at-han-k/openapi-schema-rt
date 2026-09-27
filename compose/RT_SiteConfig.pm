# The configuration for the disposable RT in docker-compose.yml, and nothing
# more: no mail, no plugins, no TLS. What the suite exercises is REST2, which
# is core in RT 6 and needs no configuration at all.
#
# The credentials are in plain sight on purpose -- this RT is built by `docker
# compose up`, thrown away by `docker compose down -v`, and must not be
# reachable from anywhere but the machine running the suite.

Set($rtname, 'localhost');
Set($Organization, 'localhost');

Set($WebDomain, 'localhost');
# The port INSIDE the container. docker-compose.yml publishes it on
# ${RT_PORT:-8091}, and RT only uses this to build absolute URLs.
Set($WebPort, 8080);
Set($WebBaseURL, 'http://localhost:8080');

### Database ###
Set($DatabaseType, 'Pg');
Set($DatabaseHost, 'db');
Set($DatabasePort, '5432');
Set($DatabaseName, 'rt6');
Set($DatabaseUser, 'rt_user');
Set($DatabasePassword, 'rt_pass');
Set($DatabaseAdmin, 'rt_user');

### Logging ###
# To the container's stderr, so `docker compose logs rt` is the whole story.
Set($LogToSTDERR, 'info');
Set($LogToSyslog, '');
Set($LogToFile, '');

# Nothing here sends mail, and an RT that tries to is an RT that hangs on a
# timeout while the suite waits for a ticket create.
Set($MailCommand, 'testfile');

1;
