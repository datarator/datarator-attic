[![Travis](https://travis-ci.org/datarator/datarator.png?branch=master)](https://travis-ci.org/datarator/datarator) [![Coverage Status](https://coveralls.io/repos/datarator/datarator/badge.png?branch=master)](https://coveralls.io/r/datarator/datarator?branch=master)
[![Code Climate](https://codeclimate.com/github/datarator/datarator/badges/gpa.svg)](https://codeclimate.com/github/datarator/datarator)
[![](https://badge.imagelayers.io/datarator/datarator:edge.svg)](https://imagelayers.io/?images=datarator/datarator:edge 'Get your own badge on imagelayers.io')

# Datarator

Stateless data generator with HTTP based JSON API.

# Running

## Run dockerized

* Using official immage:

		docker run -p 9292:9292 --rm --name datarator datarator/datarator:edge

* or building docker image locally:

		docker build -t datarator:edge . && \
		docker run -p 9292:9292 --rm --name datarator datarator:edge

## Build & Run

1. make sure to have ruby + bundler installed
	for Ubuntu run:

		sudo apt-get install ruby ruby-dev
		gem install bundler --user-install

1. build from source:

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

# Use

	curl -H "content-type: application/json" -X POST -d '{"template":"csv","document":"foo_document","count":"1","columns":[{"name":"greeting","type":"const", "options":{"value":"hello"}},{"name":"from","type":"const","options":{"value":"from"}},{"name":"server","type":"const","options":{"value":"datarator"}}],"options":{"header":"false", "separator": " "}}' http://127.0.0.1:9292/api/schemas

# JSON API

##JSON syntax:
 
 ```javascript
{
	"template": "<template_name>",
	"document": "<document_name>",
	"count": "<count>",
	"locale": "<locale>",
	"columns": [ < column > , < column > , ...],
	"options": < options >
}
```

Legend:

* `<template_name>` - name of the output template (see [Output templates](#output-templates))
* `<document_name>` - name of the document
* `<count>` - generated rows count
* `<locale>` - locale (ignored currently)
* `<column>` - column to generate (see [Column](#column))
* `<options>` - options for generation (see [Options](#options))

##Output templates

Following output templates are available:

* [`csv`](#csv)
* [`sql`](#sql)
* [`liquibase xml`](#liquibase-xml)
* [`liquibase yaml`](#liquibase-yaml)
* [`liquibase json`](#liquibase-json)

###csv

Enabled via: `"template":"csv"`.

Optional [options](#options) available:

* `"header":"true"` / `"header":"false"` - whether names of the colums should included (as the 1.st row) or not. By default is `false`.
* `"empty_value":"<empty value>"`- empty value. By default is empty string.
* `"separator":"<separator>"` - the separator string to be used for joining values.

For **example**, input JSON:
```javascript
{
	"template": "csv",
	"document": "foo_document",
	"count": "3",
	"columns": [{
		"name": "name1",
		"type": "const",
		"options": {
			"value": "value1"
		}
	}, {
		"name": "name2",
		"type": "const",
		"options": {
			"value": "value2"
		}
	}, {
		"name": "name3",
		"type": "const",
		"emptyPercent": "100",
		"options": {
			"value": "value2"
		}
	}],
	"options": {
		"header": "true",
		"empty_value": "NULL"
	}
}
```
results in:

    	name1,name2,name3
    	value1,value2,NULL
    	value1,value2,NULL
    	value1,value2,NULL

###sql

Enabled via: `"template":"sql"`.

For **example**, input JSON:
```javascript
{
	"template": "sql",
	"document": "foo_document",
	"count": "3",
	"columns": [{
		"name": "name1",
		"type": "const",
		"options": {
			"value": "value1"
		}
	}, {
		"name": "name2",
		"type": "const",
		"options": {
			"value": "value2"
		}
	}]
}
```
results in:
```sql
    	INSERT INTO (name1,name2) values ('value1','value2');
    	INSERT INTO (name1,name2) values ('value1','value2');
    	INSERT INTO (name1,name2) values ('value1','value2');
```
###liquibase xml

Enabled via: `"template":"liquibase.xml"`.

Optional [options](#options) available:

* `"changeset":"true"` / `"changeset":"false"` - whether changeset section should be included or not. By default is `false`.

For **example**, input JSON:
```javascript
{
	"template": "liquibase.xml",
	"document": "foo_document",
	"count": "3",
	"columns": [{
		"name": "name1",
		"type": "const",
		"options": {
			"value": "value1"
		}
	}, {
		"name": "name2",
		"type": "const",
		"options": {
			"value": "value2"
		}
	}],
	"options": {
		"changeset": "true"
	}
}
```
results in:
```xml
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
```
###liquibase yaml

Enabled via: `"template":"liquibase.yaml"`.

Optional [options](#options) available:

* `"changeset":"true"` / `"changeset":"false"` - whether changeset section should be included or not. By default is `false`.

For **example**, input JSON:
```javascript
{
	"template": "liquibase.yaml",
	"document": "foo_document",
	"count": "3",
	"columns": [{
		"name": "name1",
		"type": "const",
		"options": {
			"value": "value1"
		}
	}, {
		"name": "name2",
		"type": "const",
		"options": {
			"value": "value2"
		}
	}],
	"options": {
		"changeset": "true"
	}
}
```
results in:
```yaml
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
```
####liquibase json

Enabled via: `"template":"liquibase.json"`.

Optional [options](#options) available:

* `"changeset":"true"` / `"changeset":"false"` - whether changeset section should be included or not. By default is `false`.

For **example**, input JSON:
```javascript
{
	"template": "liquibase.json",
	"document": "foo_document",
	"count": "3",
	"columns": [{
		"name": "name1",
		"type": "const",
		"options": {
			"value": "value1"
		}
	}, {
		"name": "name2",
		"type": "const",
		"options": {
			"value": "value2"
		}
	}],
	"options": {
		"changeset": "true"
	}
}
```
results in:
```javascript
    databaseChangeLog: [
        {
           "changeset"
                "author": "datarator.io"
                "id": "foo_document-1418426254"
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
```
##Options

Holds [template](#output-templates) (if present in root node) or [column](#column) specific options (if present in column node).

Options syntax:

    	{"<name>":"<value>"}}

Legend:

* `<name>` - name of the option
* `<value>` - value of the option

##Column

Column syntax:
```javascript
{
	"name": "<name>",
	"type": "<type>",
	"emptyPercent": "<emptyPercent>",
	"options": < options >
}
```

Legend:

* `<name>` - name of the option
* `<value>` - value of the option
* `<emptyPercent>` - (optional) empty values percent
* `<options>` - (optional) column options (see [Options](#options))


Following column types are available:

* without column nesting supported:
	* [`const`](#const)
	* [`row_index`](#row_index)
	* [`copy`](#copy)
	* name:
		* [`name.name`](#namename)
		* [`name.first_name`](#namefirst_name)
		* [`name.prefix`](#nameprefix)
		* [`name.suffix`](#namesuffix)
		* [`name.title`](#nametitle)
	* [`bitcoin.address`](#bitcoinaddress)
	* book:
		* [`book.name`](#bookname)
		* [`book.publisher`](#bookpublisher)
		* [`book.genre`](#bookgenre)
	* [`boolean`](#boolean)
	* code:
	 	* [`code.ean`](#codeean)
	 	* [`code.isbn`](#codeisbn)
	* color:
	 	* [`color.hex`](#colorhex)
	 	* [`color.name`](#colorname)
	* credit card:
	 	* [`credit_card.number`](#credit_cardnumber)
	 	* [`credit_card.type`](#credit_cardtype)
	* number:
		* [`number.binary`](#number_binary)
		* [`number.decimal`](#number_decimal)
		* [`number.hexadecimal`](#number_hexadecimal)
		* [`number.octal`](#number_octal)
	* [`regexp`](#regexp)
* with column nesting supported:
	* [`list.seq`](#listseq)
	* [`list.rand`](#listrand)
	* [`join`](#join)

###const

Generates constant value provided in options.

Mandatory [options](#options) available:

* `"value":"<value>"` - the constant value to generate.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "const",
	"options": {
		"value": "value1"
	}
}]
```
results in value:

    	value1

###row_index

Generates row index of the currently generated row.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "row_index"
}]
```
results in value:

    	0
    	1
    	2
    	3
    	...

###copy

Generates the same value as the column referred.

Mandatory [options](#options) available:

* `"from":"<column_name>"` - the column name whose value is to be copied.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "const",
	"options": {
		"value": "value1"
	}
}, {
	"name": "name2",
	"type": "copy",
	"options": {
		"from": "name1"
	}
}]
```

results (for columns: `name1` as well as `name2`) in value:

    	value1

###name.name

Generates the random name value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "name.name"
}]
```
could result in value:

    	Christophe Bartell

###name.first_name

Generates the random first name value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "name.first_name"
}]
```
could result in value:

    	Christophe
    	
###name.last_name

Generates the random last name value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "name.last_name"
}]
```
could result in value:

    	Bartell

###name.prefix

Generates the random name "prefix" value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "name.prefix"
}]
```
could result in value:

    	Mr.

###name.suffix

Generates the random name "suffix" value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "name.suffix"
}]
```
could result in value:

    	IV

###name.title

Generates the random name "title" value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "name.title"
}]
```

could result in value:

    	Legacy Creative Director

###bitcoin.address

Generates the random bitcoin address value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "bitcoin.address"
}]
```

could result in value:

    	1HUoGjmgChmnxxYhz87YytV4gVjfPaExmh

###book.name

Generates the random book name value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "book.name"
}]
```

could result in value:

    	The Odd Sister

###book.publisher

Generates the random book publisher value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "book.publisher"
}]
```

could result in value:

    	Opus Reader

###book.genre

Generates the random book genre value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "book.genre"
}]
```

could result in value:

    	Mystery

###boolean

Generates the random boolean.

Optional [options](#options) available:

* `"true_ratio":"<true_ratio>"` - the true ratio (in range: <0,1>)

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "boolean",
	"options": {
		"true_ratio": 0.5
	}
}]
```

could result in value:

    	true

###code.ean

Generates the random ean code value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "code.ean"
}]
```

could result in value:

    	4600051000057

###code.isbn

Generates the random isbn code value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "code.isbn"
}]
```

could result in value:

    	759021701-8

###color.hex

Generates the random hex color value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "color.hex"
}]
```
could result in value:

    	#31a785

###color.name

Generates the random color name value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "color.name"
}]
```

could result in value:

    	red

###credit_card.number

Generates the random credit card number value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "credit_card.number"
}]
```

could result in value:

    	1212-1221-1121-1234

###credit_card.type

Generates the random credit card type value.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "credit_card.type"
}]
```

could result in value:

    	visa

###number.binary

Generates the random binary number.

Optional [options](#options) available:

* `"max":"<max>"` - the maxiumum value (by default is 10).
* `"min":"<min>"` - the minimum value (by default is 0).

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "number.binary",
	"options": {
		"min": 1,
		"max": 10
	}
}]
```

could result in value:

    	10

###number.decimal

Generates the random decimal number.

Optional [options](#options) available:

* `"max":"<max>"` - the maxiumum value (by default is 10).
* `"min":"<min>"` - the minimum value (by default is 0).

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "number.decimal",
	"options": {
		"min": 1,
		"max": 10
	}
}]
```

could result in value:

    	2

###number.hexadecimal

Generates the random hexadecimal number.

Optional [options](#options) available:

* `"max":"<max>"` - the maxiumum value (by default is 10).
* `"min":"<min>"` - the minimum value (by default is 0).

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "number.hexadecimal",
	"options": {
		"min": 1,
		"max": 10
	}
}]
```
could result in value:

    	A

###number.octal

Generates the random octal number.

Optional [options](#options) available:

* `"max":"<max>"` - the maxiumum value (by default is 10).
* `"min":"<min>"` - the minimum value (by default is 0).

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "number.octal",
	"options": {
		"min": 1,
		"max": 10
	}
}]
```


could result in value:

    	2

###regexp

Generates the random string matching specified regular expression.

Mandatory [options](#options) available:

* `"pattern":"<pattern>"` - the pattern to match.

Optional [options](#options) available:

* `"escape": true|false` - whether to escape (quote) result or not (used for specfific output formats only).

For **example**, input JSON:
```javascript
"columns": [{
	"name": "foo",
	"type": "regexp",
	"options": {
		"pattern": "[0-9]{1,4}"
	}
}]
```

could result in value:

    	720

###list.seq

Picks next value in a sequence from the provided nested column values.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "list.seq",
	"columns": [{
		"name": "name1",
		"type": "const",
		"options": {
			"value": "value1"
		}
	}, {
		"name": "name2",
		"type": "const",
		"options": {
			"value": "value2"
		}
	}]
}]
```

 results in values:

    	value1
    	value2
    	value1
    	value2
    	...

###list.rand

Picks random value from the provided nested column values.

For **example**, input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "list.seq",
	"columns": [{
		"name": "name1",
		"type": "const",
		"options": {
			"value": "value1"
		}
	}, {
		"name": "name2",
		"type": "const",
		"options": {
			"value": "value2"
		}
	}]
}]
```

 could result in values:

    	value2
    	value1
    	value1
    	value2
    	...

###join

Joins nested column values with the separator (optionaly) provided.

Optional [options](#options) available:

* `"separator":"<separator>"` - the separator string to be used for joining values.

For **example** (without separator), input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "join",
	"columns": [{
		"name": "name1",
		"type": "const",
		"options": {
			"value": "value1"
		}
	}, {
		"name": "name2",
		"type": "const",
		"options": {
			"value": "value2"
		}
	}]
}]
```

 would result in value:

    	value1value2

For **example** (with separator), input JSON:
```javascript
"columns": [{
	"name": "name1",
	"type": "join",
	"columns": [{
		"name": "name1",
		"type": "const",
		"options": {
			"value": "value1"
		}
	}, {
		"name": "name2",
		"type": "const",
		"options": {
			"value": "value2"
		}
	}]
}, "options": {
	"separator": ", "
}]
```
 would result in value:

    	value1, value2

## Contributing

1. Fork it ( https://github.com/datarator/datarator/fork )
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create a new Pull Request

