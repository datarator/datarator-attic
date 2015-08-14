[![Travis](https://travis-ci.org/datarator/datarator.png?branch=master)](https://travis-ci.org/datarator/datarator) [![Coverage Status](https://coveralls.io/repos/datarator/datarator/badge.png?branch=master)](https://coveralls.io/r/datarator/datarator?branch=master)
[![Code Climate](https://codeclimate.com/github/datarator/datarator/badges/gpa.svg)](https://codeclimate.com/github/datarator/datarator)
# Datarator

(stateless) data generator, with:

* web UI as well as
* HTTP based JSON API.

# Hosting options

* hosted instance - **TODO link**
* [self-hosted](#self-hosted) - if you want to use your own infrastructure.

## Self-hosted

### Build from source & run

1. make sure to have ruby + bundler installed
	for Ubuntu run:

		sudo apt-get install ruby ruby-dev
		gem install bundler --user-install
1. build from source (TODO outdated as UI was added):

		git clone https://github.com/datarator/datarator.git && \
		pushd datarator && \
		bundle install && \
		gem build datarator.gemspec && \
		gem install datarator-0.0.1.gem && \
		popd
1. and run:

		datarator
1. console should contain:

		Datarator starting ...

##API options

* `<server-url>` - web UI - to be used for occasional usage or to create JSON interactively or
* POST: `<server-url>/dump` - HTTP JSON API - for reproducable test data.

## JSON API

###JSON syntax:
 
	{"template":"<template_name>","document":"<document_name>","count":"<count>","locale":"<locale>","columns":[<column>,<column>,...],"options":<options>}

Legend:

* `<template_name>` - name of the output template (see [Output templates](#output-templates))
* `<document_name>` - name of the document
* `<count>` - generated rows count
* `<locale>` - locale (ignored currently)
* `<column>` - column to generate (see [Column](#column))
* `<options>` - options for generation (see [Options](#options))

###Output templates

Following collumn types are available:

* [`csv`](#csv)
* [`sql`](#sql)
* [`liquibase xml`](#liquibase-xml)
* [`liquibase yaml`](#liquibase-yaml)
* [`liquibase json`](#liquibase-json)

####csv

Enabled via: `"template":"csv"`.

Optional [options](#options) available:

* `"header":"true"` / `"header":"false"` - whether names of the colums should included (as the 1.st row) or not. By default is `false`.
* `"empty_value":"XYZ"`- empty value. By default is empty string.

For **example**, input JSON:

    	{"template":"csv","document":"foo_document","count":"3","columns":[{"name":"name1","type":"const", "options":{"value":"value1"}},{"name":"name2","type":"const","options":{"value":"value2"}},{"name":"name3","type":"const","emptyPercent":"100","options":{"value":"value2"}}],"options":{"header":"true","empty_value":"NULL"}}

results in:

    	name1,name2,name3
    	value1,value2,NULL
    	value1,value2,NULL
    	value1,value2,NULL

####sql

Enabled via: `"template":"sql"`.

For **example**, input JSON:

    	{"template":"sql","document":"foo_document","count":"3","columns":[{"name":"name1","type":"const", "options":{"value":"value1"}},{"name":"name2","type":"const","options":{"value":"value2"}}]}

results in:

    	INSERT INTO (name1,name2) values ('value1','value2');
    	INSERT INTO (name1,name2) values ('value1','value2');
    	INSERT INTO (name1,name2) values ('value1','value2');

####liquibase xml

Enabled via: `"template":"liquibase.xml"`.

Optional [options](#options) available:

* `"changeset":"true"` / `"changeset":"false"` - whether changeset section should be included or not. By default is `false`.

For **example**, input JSON:

    	{"template":"liquibase.xml","document":"foo_document","count":"3","columns":[{"name":"name1","type":"const", "options":{"value":"value1"}},{"name":"name2","type":"const","options":{"value":"value2"}}],"options":{"changeset":"true"}}

results in:

	<databaseChangeLog
	xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
	  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	  xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.0.xsd">

	  <changeset author="datarator.io" id="foo_document-1418423861">
	    <insert tableName="foo_document">
	      <column name="name1" value="value1"/>
	      <column name="name2" value="value2"/>
	    </insert>
	    <insert tableName="foo_document">
	      <column name="name1" value="value1"/>
	      <column name="name2" value="value2"/>
	    </insert>
	    <insert tableName="foo_document">
	      <column name="name1" value="value1"/>
	      <column name="name2" value="value2"/>
	    </insert>
	  </changeset>

####liquibase yaml

Enabled via: `"template":"liquibase.yaml"`.

Optional [options](#options) available:

* `"changeset":"true"` / `"changeset":"false"` - whether changeset section should be included or not. By default is `false`.

For **example**, input JSON:

    	{"template":"liquibase.yaml","document":"foo_document","count":"3","columns":[{"name":"name1","type":"const", "options":{"value":"value1"}},{"name":"name2","type":"const","options":{"value":"value2"}}],"options":{"changeset":"true"}}

results in:

	databaseChangeLog:
	  - changeset
	      author: datarator.io
	      id: foo_document-1418426125
	      changes:
		- insert:
		    tableName: foo_document
		    columns:
		      - column:
			  name: name1
			  value: value1
		      - column:
			  name: name2
			  value: value2
		- insert:
		    tableName: foo_document
		    columns:
		      - column:
			  name: name1
			  value: value1
		      - column:
			  name: name2
			  value: value2
		- insert:
		    tableName: foo_document
		    columns:
		      - column:
			  name: name1
			  value: value1
		      - column:
			  name: name2
			  value: value2

####liquibase json

Enabled via: `"template":"liquibase.json"`.

Optional [options](#options) available:

* `"changeset":"true"` / `"changeset":"false"` - whether changeset section should be included or not. By default is `false`.

For **example**, input JSON:

    	{"template":"liquibase.json","document":"foo_document","count":"3","columns":[{"name":"name1","type":"const", "options":{"value":"value1"}},{"name":"name2","type":"const","options":{"value":"value2"}}],"options":{"changeset":"true"}}

results in:

    databaseChangeLog: [
        {
           "changeset"
                "author": "datarator.io"
                "id": foo_document-1418426254"
                "changes": [
                    {
		    	"insert": {
                            "tableName": "foo_document",
                            "columns" [
                                {
                                    "column": {
                                        "name": "name1",
                                        "value": "value1"
                                        },
                                    "column": {
                                        "name": "name2",
                                        "value": "value2"
                                        }
                                    },
                            ]
                        }
                        "insert": {
                            "tableName": "foo_document",
                            "columns" [
                                {
                                    "column": {
                                        "name": "name1",
                                        "value": "value1"
                                        },
                                    "column": {
                                        "name": "name2",
                                        "value": "value2"
                                        }
                                    },
                            ]
                        }
                        "insert": {
                            "tableName": "foo_document",
                            "columns" [
                                {
                                    "column": {
                                        "name": "name1",
                                        "value": "value1"
                                        },
                                    "column": {
                                        "name": "name2",
                                        "value": "value2"
                                        }
                                    },
                            ]
                        }
                    }
                ]
            }
        ]

###Options

Holds [template](#output-templates) (if present in root node) or [column](#column) specific options (if present in column node).

Options syntax:

    	{"<name>":"<value>"}}

Legend:

* `<name>` - name of the option
* `<value>` - value of the option

###Column

Column syntax:

    	{"name":"<name>","type":"<type>","emptyPercent":"<emptyPercent>","options":<options>}

Legend:

* `<name>` - name of the option
* `<value>` - value of the option
* `<emptyPercent>` - (optional) empty values percent
* `<options>` - (optional) column options (see [Options](#options))


Following collumn types are available:

* without column nesting supported:
	* [`const`](#const)
	* [`row_index`](#row_index)
	* [`copy`](#copy)
	* name generating columns:
		* [`name.name`](#namename)
		* [`first_name`](#namefirst_name)
* with column nesting supported:
	* [`list.seq`](#listseq)
	* [`list.rand`](#listrand)
	* [`join`](#join)

####const

Generates constant value provided in options.

Mandatory [options](#options) available:

* `"value":"<value>"` - the constant value to generate.

For **example**, input JSON:

    	"columns":[{"name":"name1","type":"const", "options":{"value":"value1"}}]

results in value:

    	value1

####row_index

Generates row index of the currently generated row.

For **example**, input JSON:

    	"columns":[{"name":"name1","type":"row_index"}]

results in value:

    	0
    	1
    	2
    	3
    	...

####copy

Generates the same value as the column referred.

Mandatory [options](#options) available:

* `"from":"<column_name>"` - the column name whose value is to be copied.

For **example**, input JSON:

    	"columns":[{"name":"name1","type":"const", "options":{"value":"value1"}}, {"name":"name2","type":"copy", "options":{"from":"name1"}}]

results (for columns: `name1` as well as `name2`) in value:

    	value1

####name.name

Generates the random name value.

For **example**, input JSON:

    	"columns":[{"name":"name1","type":"name.name"}]

could result in value:

    	Christophe Bartell

####name.first_name

Generates the random first name value.

For **example**, input JSON:

    	"columns":[{"name":"name1","type":"name.first_name"}]

could result in value:

    	Christophe

####list.seq

Picks next value in a sequence from the provided nested column values.

For **example**, input JSON:

    	"columns":[{"name":"name1","type":"list.seq","columns":[{"name":"name1","type":"const", "options":{"value":"value1"}},{"name":"name2","type":"const", "options":{"value":"value2"}}]}]

 results in values:

    	value1
    	value2
    	value1
    	value2
    	...

####list.rand

Picks random value from the provided nested column values.

For **example**, input JSON:

    	"columns":[{"name":"name1","type":"list.seq","columns":[{"name":"name1","type":"const", "options":{"value":"value1"}},{"name":"name2","type":"const", "options":{"value":"value2"}}]}]

 could result in values:

    	value2
    	value1
    	value1
    	value2
    	...

####join

Joins nested column values with the separator (optionaly) provided.

Optional [options](#options) available:

* `"separator":"<separator>"` - the separator string to be used for joining values.

For **example** (without separator), input JSON:

    	"columns":[{"name":"name1","type":"join","columns":[{"name":"name1","type":"const", "options":{"value":"value1"}},{"name":"name2","type":"const", "options":{"value":"value2"}}]}]

 would result in value:

    	value1value2

For **example** (with separator), input JSON:

    	"columns":[{"name":"name1","type":"join","columns":[{"name":"name1","type":"const", "options":{"value":"value1"}},{"name":"name2","type":"const", "options":{"value":"value2"}}]},"options":{"separator":", "}]

 would result in value:

    	value1, value2

## Contributing

1. Fork it ( https://github.com/[my-github-username]/datarator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

