FROM alpine:3.3

MAINTAINER Peter Butkovic <butkovic@gmail.com>

ENV DATARATOR_HOME /usr/local/share/datarator

COPY . $DATARATOR_HOME

RUN apk --update upgrade && \
	apk add ca-certificates ruby && \
# add gem build deps
	apk add ruby-dev ruby-rdoc ruby-irb ruby-bundler ruby-io-console && \
# add native ext build deps
	apk add build-base linux-headers && \
# add nginx
	apk add nginx && \
	cd $DATARATOR_HOME && \
# build + install datarator
	gem install bundler && \
	bundle install --without development && \
	gem build datarator.gemspec && \
	gem install datarator-0.0.1.gem && \
	gem uninstall bundler && \
# remove native ext build deps
	apk del build-base linux-headers && \
# remove gem build deps
	apk del ruby-dev ruby-rdoc ruby-irb ruby-bundler ruby-io-console && \
# clean apk cache
	rm -rf /var/cache/apk/*

COPY config/nginx.conf /etc/nginx/nginx.conf

WORKDIR $DATARATOR_HOME

EXPOSE 9292

CMD unicorn -c config/unicorn.rb -E production -D && nginx -g "daemon off;"
