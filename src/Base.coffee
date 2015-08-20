#
# Base class for Maslosoft binding handlers
#
class @Maslosoft.Ko.Balin.Base

	#
	# Whenever to register binding handler as writable
	# @var boolean
	#
	writable: true

	#
	# @var @Maslosoft.Ko.Balin.Options
	#
	options: {}

	# Class constructor
	# @param options @Maslosoft.Ko.Balin.Options
	#
	constructor: (options = {}) ->
		for name, value of options
			@options[name] = value

	#
	# Get value from model
	#
	getValue: (valueAccessor, defaults = '') =>
		value = ko.unwrap(valueAccessor())
		if @options.valueField
			if @options.ec5
				value = value[@options.valueField]
			else
				value = value[@options.valueField]()
		return value or defaults
