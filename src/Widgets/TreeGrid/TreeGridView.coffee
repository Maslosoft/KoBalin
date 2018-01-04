
class Maslosoft.Ko.Balin.Widgets.TreeGrid.TreeGridView

	#
	# Plugins for tree grid
	#
	# NOTE: Order of plugins *might* be important, especially for built-in plugins
	#
	# @var Object[]
	#
	@plugins = [
		Maslosoft.Ko.Balin.Widgets.TreeGrid.Expanders
		Maslosoft.Ko.Balin.Widgets.TreeGrid.Dnd
		Maslosoft.Ko.Balin.Widgets.TreeGrid.Events
	]

	#
	# Tbody element - root of tree
	#
	# @var jQuery element
	#
	element: null

	#
	# Configuration of binding
	#
	# @var Object
	#
	config: null

	constructor: (element, valueAccessor = null, @context = 'init') ->

		@element = jQuery element
		
		if valueAccessor
			@config = {}
			@config = ko.unwrap(valueAccessor())

			for plugin in TreeGridView.plugins
				new plugin(@)

#			console.log data

	#
	# Visit each node and apply callback.
	# Callback accepts two parameters:
	#
	# * element - contains current row jQuery element
	# * data - contains data attached to element
	#
	#
	visit: (callback) ->
		items = @element.find('> tr')
		for item in items
			data = ko.dataFor(item)
			callback(jQuery(item), data)

	#
	# Visit each node starting from tree root and apply callback.
	# Callback accepts two parameters:
	#
	# * parent - contains current element parent item, might be null
	# * data - contains data attached to element
	#
	#
	visitRecursive: (callback, model = null) =>
		if not model
			ctx = ko.contextFor @element.get(0)
			model = ctx.tree
			callback null, model
			if model.children and model.children.length
				for child in model.children
					callback model, child
					@visitRecursive callback, child
			# Array node
			if model.length
				for child in model
					callback model, child
					@visitRecursive callback, child
		else
			if model.children and model.children.length
				for child in model.children
					callback model, child
					@visitRecursive callback, child
			# Array node
			if model.length
				for child in model
					callback model, child
					@visitRecursive callback, child

	getParent: (model) =>
		found = null

		one = (parent, data) ->
			if data is model
				found = parent
		# Don't set model here to start from root
		@visitRecursive one
		return found

	#
	# Check if parent have child
	#
	#
	have: (parent, child) =>

		found = false

		one = (parent, data) ->
			if data is child
				found = true

		# Start from parent here
		@visitRecursive one, parent
		return found

	remove: (model) =>
		one = (parent, data) ->
			if parent
				# Model initialized
				if parent.children
					parent.children.remove model
				# Array initialized
				else
					parent.remove model

		# Don't set model here to start from root
		@visitRecursive one

	expandAll: () ->

	collapseAll: () ->
