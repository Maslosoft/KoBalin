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