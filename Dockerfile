### 1. stage: create build image
FROM debian:stable AS ejabberd-build

ENV BUILD_PREFIX /usr/local/src

# Install build dependencies
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install -y build-essential git debhelper dpkg-dev libssl-dev libevent-dev sqlite3 libsqlite3-dev postgresql-client libpq-dev default-mysql-client default-libmysqlclient-dev libhiredis-dev libmongoc-dev libbson-dev

# Clone ejabberd
WORKDIR ${BUILD_PREFIX}
RUN git clone git://github.com/processone/ejabberd.git ejabberd

# Build ejabberd
WORKDIR ejabberd
RUN ./autogen.sh
RUN ./configure --enable-user=ejabberd --enable-mysql
RUN make install
