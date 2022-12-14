'use strict';

const assert = require('assert')
const asciidoctor = require('asciidoctor')()
require('../dist') // TODO: load lib

describe('foo', () => {
	console.log(asciidoctor.convert('godoc:foo[]'))
})
