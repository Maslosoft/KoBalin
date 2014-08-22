#
# Html value binding
# WARNING This MUST have parent context, or will not work
# TODO Check if sortable is available, and if active, add `[contenteditable]` to `cancel` option
# TODO Refactor this, to inherit from HtmlValue
#
class @Maslosoft.Ko.Balin.TextValue extends @Maslosoft.Ko.Balin.Base

	# Counter for id generator
	idCounter = 0

	getText: (element) =>
		element.textContent || element.innerText || ""

	init: (element, valueAccessor, allBindingsAccessor, context) =>
		element.setAttribute('contenteditable', true)

		# Generate some id if not set, see notes below why
		if not element.id
			element.id = "Maslosoft-Ko-Balin-TextValue-#{idCounter++}"

		handler = (e) =>

			# On some situations element might be null (sorting), ignore this case
			if not element then return

			# This is required in some scenarios, specifically when sorting htmlValue elements
			element = document.getElementById(element.id)
			if not element then return

			accessor = valueAccessor()
			modelValue = @getValue(valueAccessor)
			elementValue = element.textContent || element.innerText || ""
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
		if typeof element.innerText isnt 'undefined'
			if element.innerText isnt value
				element.innerText = value
		if typeof element.textContext isnt 'undefined'
			if element.textContext isnt value
				element.textContext = value

		return