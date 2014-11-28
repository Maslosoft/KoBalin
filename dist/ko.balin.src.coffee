if not @Maslosoft
	@Maslosoft = {}
if not @Maslosoft.Ko
	@Maslosoft.Ko = {}
if not @Maslosoft.Ko.Balin
	@Maslosoft.Ko.Balin = {}

#
# Register binding handler
# @param string name
# @params Maslosoft.Ko.Balin.Base handler
#
@Maslosoft.Ko.Balin.register = (name, handler) ->
	ko.bindingHandlers[name] = handler
	
	if handler.writable
		ko.expressionRewriting.twoWayBindings[name] = true

#
# Register default set of binding handlers, or part of default set
#
@Maslosoft.Ko.Balin.registerDefaults = (handlers = null) ->
	# In alphabetical order
	config = {
		fancytree: Maslosoft.Ko.Balin.Fancytree
		fileSizeFormatter: Maslosoft.Ko.Balin.FileSizeFormatter
		href: Maslosoft.Ko.Balin.Href
		htmlValue: Maslosoft.Ko.Balin.HtmlValue
		src: Maslosoft.Ko.Balin.Src
		textValue: Maslosoft.Ko.Balin.TextValue
		selected: Maslosoft.Ko.Balin.Selected
	}
	
	if handlers isnt null
		for index, value of handlers
			Maslosoft.Ko.Balin.register(value, new config[value])
	else
		for index, value of config
			Maslosoft.Ko.Balin.register(index, new value)

#
# Register default set of event handlers, or part of default set
#
@Maslosoft.Ko.Balin.registerEvents = (handlers = null) ->
	config = {
		'mousedown',
		'mouseup',
		'mouseover',
		'mouseout',
	}
	if handlers isnt null
		for index, value of handlers
			Maslosoft.Ko.Balin.makeEventHandlerShortcut(value)
	else
		for index, value of config
			Maslosoft.Ko.Balin.makeEventHandlerShortcut(value)

@Maslosoft.Ko.Balin.makeEventHandlerShortcut = (eventName) ->
	ko.bindingHandlers[eventName] = init: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
		newValueAccessor = ->
			result = {}
			result[eventName] = valueAccessor()
			result

		ko.bindingHandlers["event"]["init"].call this, element, newValueAccessor, allBindings, viewModel, bindingContext

	return
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
	options: null

	# Class constructor
	# @param options @Maslosoft.Ko.Balin.Options
	#
	constructor: (@options = {}) ->

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
		
	#
	# Set value back to model
	#
	setValue: (valueAccessor, value) ->
		# TODO
class @Maslosoft.Ko.Balin.Options

	# Set this if need to access complex date objects
	# @var string
	#
	valueField: null

	# Whenever to use ko ecmascript 5 plugin
	# Will autodetect if not set
	# @var boolean
	#
	ec5: null

	afterUpdate: null

	constructor: (values = {}) ->

		for index, value of values
			@[index] = value

		if @ec5 is null
			@ec5 = !!ko.track

		if @afterUpdate is null
			@afterUpdate = (element, value) ->
				


#
# Configuration class for date bindings
#
class @Maslosoft.Ko.Balin.DateOptions extends @Maslosoft.Ko.Balin.Options

	# Date source format
	# @var string
	#
	sourceFormat: 'unix'

	# Date display format
	# @var string
	#
	displayFormat: 'YYYY-MM-DD'
#
# Configuration class for datetime bindings
#
class @Maslosoft.Ko.Balin.DateTimeOptions extends @Maslosoft.Ko.Balin.Options

	# DateTime source format
	# @var string
	#
	sourceFormat: 'unix'

	# DateTime display format
	# @var string
	#
	displayFormat: 'YYYY-MM-DD hh:mm'
#
# Configuration class for time bindings
#
class @Maslosoft.Ko.Balin.TimeOptions extends @Maslosoft.Ko.Balin.Options

	# Time source format
	# @var string
	#
	sourceFormat: 'unix'

	# Time display format
	# @var string
	#
	displayFormat: 'hh:mm'
class @Maslosoft.Ko.Balin.DateTime extends @Maslosoft.Ko.Balin.Base

	constructor: (options) ->
		@options = new @Maslosoft.Ko.Balin.DateTimeOptions(options)

###
One-way date/time formatter
###
class @Maslosoft.Ko.Balin.MomentFormatter extends @Maslosoft.Ko.Balin.Base
	
	init: (element, valueAccessor, allBindingsAccessor, viewModel) =>
		moment.lang @options.lang
		return

	update: (element, valueAccessor, allBindingsAccessor, viewModel) =>
		value = @getValue(valueAccessor)
		element.innerHTML = moment[@sourceformat](value).format(@displayformat)
		return
#
# Fancytree binding
# TODO Allow sytaxes:
# data-bind="fancytree: data"
# data-bind="fancytree: {data: data}"
# data-bind="fancytree: {data: data, options: <fancyTree-options>, autoExpand: true|false}"
# TODO When using two or more trees from same data, only first one works properly
#
class @Maslosoft.Ko.Balin.Fancytree extends @Maslosoft.Ko.Balin.Base

	tree: null
	element: null

	getData: (valueAccessor) ->
		# Verbose syntax, at least {data: data}
		value = @getValue(valueAccessor) or []
		if value.data
			return value.data
		return value

	init: (element, valueAccessor, allBindingsAccessor, context) =>

		# Tree options
		options = valueAccessor().options or {}
		options.source = @getData(valueAccessor)

		jQuery(element).fancytree(options);

	update: (element, valueAccessor, allBindingsAccessor, viewModel) =>
		config = @getValue(valueAccessor)
		element = jQuery element

		handler = () =>

			if not element.find('.ui-fancytree').length then return
			
			element.fancytree 'option', 'source', @getData(valueAccessor)

			# Autoexpand handling
			if config.autoExpand
				element.fancytree('getRootNode').visit (node) ->
					node.setExpanded true
			element.focus()

		# Put rendering to end of queue to ensure bindings are evaluated
		setTimeout handler, 0
#
# One-way file size formatter
#
class @Maslosoft.Ko.Balin.FileSizeFormatter extends @Maslosoft.Ko.Balin.Base

	units: {
		binary: [
				"kiB"
				"MiB"
				"GiB"
				"TiB"
				"PiB"
				"EiB"
				"ZiB"
				"YiB"
			],
		decimal: [
				"kB"
				"MB"
				"GB"
				"TB"
				"PB"
				"EB"
				"ZB"
				"YB"
		]
	}

	binary: true

	init: (element, valueAccessor, allBindingsAccessor, viewModel) =>

	update: (element, valueAccessor, allBindingsAccessor, viewModel) =>
		value = @getValue(valueAccessor) or 0
		#
		# TODO This should also be configurable via at binding
		#
		binary = @binary
		decimal = !@binary
		
		step = 1024 if binary
		step = 1000 if decimal
		format = (bytes) =>
			bytes = parseInt(bytes)
			if bytes < step
				return bytes + ' B'
			i = -1
			units = @units.binary if binary
			units = @units.decimal if decimal
			loop
				bytes = bytes / step
				i++
				break unless bytes > step
			if units[i]
				Math.max(bytes, 0.1).toFixed(1) + ' ' + units[i]
			else
				Math.max(bytes, 0.1).toFixed(1) + " ~*#{i * step} * #{step} B"

		element.innerHTML = format(value)
#
# Href binding handler
#
class @Maslosoft.Ko.Balin.Href extends @Maslosoft.Ko.Balin.Base
	
	init: (element, valueAccessor, allBindingsAccessor, context) =>
		if not element.href
			element.setAttribute('href', '')
		if element.tagName.toLowerCase() isnt 'a'
			console.warn('href binding should be used only on `a` tags')

		# Stop propagation handling
		stopPropagation = allBindingsAccessor.get('stopPropagation') or false
		if stopPropagation
			ko.utils.registerEventHandler element, "click", (e) ->
				e.stopPropagation()

	update: (element, valueAccessor, allBindings) =>
		href = @getValue(valueAccessor)
		target = allBindings.get('target') or ''
		if element.href isnt href
			element.href = href
		if element.target isnt target
			element.target = target
#
# Html value binding
# WARNING This MUST have parent context, or will not work
#
class @Maslosoft.Ko.Balin.HtmlValue extends @Maslosoft.Ko.Balin.Base

	# Counter for id generator
	idCounter = 0
	
	constructor: (options = {}) ->
		super(options)
		
		if ko.bindingHandlers.sortable and ko.bindingHandlers.sortable.options
			# Allow `contenteditable` to get focus
			ko.bindingHandlers.sortable.options.cancel = ':input,button,[contenteditable]'

	getElementValue: (element) ->
		return element.innerHTML

	setElementValue: (element, value) ->
		element.innerHTML = value

	init: (element, valueAccessor, allBindingsAccessor, context) =>
		
		element.setAttribute('contenteditable', true)

		# Generate some id if not set, see notes below why
		if not element.id
			element.id = "Maslosoft-Ko-Balin-HtmlValue-#{idCounter++}"

		handler = (e) =>
		
			# On some situations element might be null (sorting), ignore this case
			if not element then return

			# This is required in some scenarios, specifically when sorting htmlValue elements
			element = document.getElementById(element.id)
			if not element then return
			
			accessor = valueAccessor()
			modelValue = @getValue(valueAccessor)
			elementValue = @getElementValue(element)
			if ko.isWriteableObservable(accessor)
				# Update only if changed
				if modelValue isnt elementValue
#					console.log "Write: #{modelValue} = #{elementValue}"
					accessor(elementValue)

		# NOTE: Event must be bound to parent node to work if parent has contenteditable enabled
		ko.utils.registerEventHandler element, "keyup, input", handler

		# This is to allow interation with tools which could modify content, also to work with drag and drop
		ko.utils.registerEventHandler document, "mouseup", handler
		return

	update: (element, valueAccessor) =>
		value = @getValue(valueAccessor)
		if @getElementValue(element) isnt value
			@setElementValue(element, value)
		return
#
# Selected binding
# This adds class from options if value is true
#
class @Maslosoft.Ko.Balin.Selected extends @Maslosoft.Ko.Balin.Base

	writable: false

	className: 'selected'

	update: (element, valueAccessor) =>
		value = @getValue(valueAccessor)
		if value
			ko.utils.toggleDomNodeCssClass(element, @className, true);
		else
			ko.utils.toggleDomNodeCssClass(element, @className, false);
		return
#
# Src binding handler
#
class @Maslosoft.Ko.Balin.Src extends @Maslosoft.Ko.Balin.Base

	init: (element, valueAccessor, allBindingsAccessor, context) =>

	update: (element, valueAccessor) =>
		src = @getValue(valueAccessor)
		if element.src isnt src
			element.src = src
#
# Html text value binding
# WARNING This MUST have parent context, or will not work
#
class @Maslosoft.Ko.Balin.TextValue extends @Maslosoft.Ko.Balin.HtmlValue

	getElementValue: (element) ->
		return element.textContent || element.innerText || ""

	setElementValue: (element, value) ->
		if typeof element.textContent isnt 'undefined'
			element.textContent = value
		if typeof element.innerText isnt 'undefined'
			element.innerText = value
@Maslosoft.Ko.getType = (type) ->
	if x and typeof x is 'object'
		if x.constructor is Date then return 'date'
		if x.constructor is Array then return 'array'
	return typeof x

@Maslosoft.Ko.objByName = (name, context = window) ->
	args = Array.prototype.slice.call(arguments, 2)
	ns = name.split "."
	func = context
	part = []
	for n, i in ns
		part.push n
		if typeof func[n] is 'undefined'
			throw new Error "Name part `#{part.join('.')}` not found while accesing #{name}"
		func = func[n]
	return func

class @Maslosoft.Ko.Track
	
	factory: (data) =>
		# Return if falsey value
		if not data then return data
		
		# Check if has prototype
		if data._class
			className = data._class.replace(/\\/g, '.')
			ref = Maslosoft.Ko.objByName(className)
			if ref
				return new ref(data)
			else
				console.warn("Class `#{className}` not found, using default object")
				console.debug(data)

		# Track generic object
		if typeof data is 'object'
			for name, value of data
				data[name] = @factory(value)
			data = ko.track(data)
			
		return data
		
		

ko.tracker = new @Maslosoft.Ko.Track
#
# Model class with automatically applied knockout bindings
#
class @Maslosoft.Ko.Balin.Model
	
	constructor: (data = null) ->

		# Reassign here is required - when using model with values from class prototype only
		for name, value of @
			if data and typeof data[name] isnt 'undefined'
				@[name] = ko.tracker.factory(data[name])
			else
				@[name] = ko.tracker.factory(value)

		ko.track(@)