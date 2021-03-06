
#
#
# Validation binding handler
#
# @see ValidationManager
#
class @Maslosoft.Binder.Validator extends @Maslosoft.Binder.Base

	# Counter for id generator
	# @static
	idCounter = 0

	constructor: (options) ->
		super new Maslosoft.Binder.ValidatorOptions()

	getElementValue: (element) ->
		# For inputs use value
		if element.tagName.toLowerCase() is 'input'
			return element.value

		# For textarea use value
		if element.tagName.toLowerCase() is 'textarea'
			return element.value

		# For rest use text value
		return element.textContent || element.innerText || ""

	init: (element, valueAccessor, allBindingsAccessor, context) =>
		configuration = @getValue(valueAccessor)
		classField = @options.classField

		pm = new PluginsManager element, classField

		validators = pm.from configuration


#   TODO Maybe below code should be used to check if class is validator compatible
#		proto = config[classField].prototype
#
#		if typeof(proto.isValid) isnt 'function' or typeof(proto.getErrors) isnt 'function' or typeof(proto.reset) isnt 'function'
#			if typeof(config[classField].prototype.constructor) is 'function'
#				name = config[classField].prototype.constructor.name
#			else
#				name = config[classField].toString()
#
#			error "Parameter `#{classField}` (of type #{name}) must be validator compatible class, binding defined on element:", element
#			continue


		manager = new ValidationManager(validators, @options)
		manager.init element

		# Generate some id if not set, see notes below why
		if not element.id
			element.id = "Maslosoft-Ko-Binder-Validator-#{idCounter++}"

		# Get initial value to evaluate only if changed
		initialVal = @getElementValue(element)

		handler = (e) =>
			# On some situations element might be null (sorting), ignore this case
			if not element then return

			# This is required in some scenarios, specifically when sorting htmlValue elements
			element = document.getElementById(element.id)
			if not element then return

			elementValue = @getElementValue(element)
			
			# Validate only if changed
			if initialVal isnt elementValue
				initialVal = elementValue
				manager.validate element, elementValue

		# NOTE: Event must be bound to parent node to work if parent has contenteditable enabled
		ko.utils.registerEventHandler element, "keyup, input", handler

		# This is to allow interaction with tools which could modify content,
		# also to work with drag and drop
		ko.utils.registerEventHandler document, "mouseup", handler


	update: (element, valueAccessor, allBindings) =>
		# NOTE: Will not trigger on value change, as it is not directly observing value.
		# Will trigger only on init
