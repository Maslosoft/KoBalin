if not @Maslosoft
	@Maslosoft = {}
if not @Maslosoft.Ko
	@Maslosoft.Ko = {}
if not @Maslosoft.Koe
	@Maslosoft.Koe = {}
if not @Maslosoft.Ko.BalinDev
	@Maslosoft.Ko.BalinDev = {}
if not @Maslosoft.Ko.BalinDev.Models
	@Maslosoft.Ko.BalinDev.Models = {}
if not @Maslosoft.Ko.BalinDev.Widgets
	@Maslosoft.Ko.BalinDev.Widgets = {}

class @Maslosoft.Ko.BalinDev.FancyTreeDropHandler

	constructor: (node, data) ->
		
	getNode: (node) =>
		console.log "Transform node..."
		console.log node
		return node

class @Maslosoft.Koe.TreeItem extends @Maslosoft.Ko.Balin.Model
	@idCounter = 0
	_class: "Maslosoft.Koe.TreeItem"
	id: 0
	title: ''
	description: ''
	children: null

	constructor: (data = null) ->
		@children = []
		super data
		@id = TreeItem.idCounter++


class @Maslosoft.Koe.Intro extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Intro"
	text: ''

class @Maslosoft.Koe.FileSizeFormatter extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.FileSizeFormatter"
	size: 0

class @Maslosoft.Koe.DecimalFormatter extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.DecimalFormatter"
	value: 0

class @Maslosoft.Koe.Href extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Href"
	filename: ''

class @Maslosoft.Koe.Src extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Src"
	filename: ''

class @Maslosoft.Koe.HtmlValue extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.HtmlValue"
	text: ''

class @Maslosoft.Koe.TextValue extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.TextValue"
	text: ''

class @Maslosoft.Koe.SortableHtmlValues extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.SortableHtmlValues"
	title: ''
	items: []

class @Maslosoft.Koe.Selected extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Selected"
	isSelected: false

class @Maslosoft.Koe.Enum extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Enum"
	status: 0

class @Maslosoft.Koe.Hidden extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Hidden"
	show: true

class @Maslosoft.Koe.Icon extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Icon"
	icon: ''
	isImage: true
	iconSize: 64
	filename: ''
	updateDate: {
		sec: 21232323
	}

class @Maslosoft.Koe.Tooltip extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Tooltip"
	title: ''

class @Maslosoft.Koe.Asset extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Asset"
	url: ''
	updateDate: {
		sec: 21232323
	}

class @Maslosoft.Koe.DateTime extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.DateTime"
	url: ''
	date: 21232323

class @Maslosoft.Koe.Nested extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Nested"
	rawI18N: ''

class @Maslosoft.Koe.Video extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Video"
	url: ''
	title: ''

class @Maslosoft.Koe.Videos extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Video"
	videos: []

class @Maslosoft.Koe.DatePicker extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.DatePicker"
	date: 1473839950


class @Maslosoft.Koe.AclUser extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.AclUser"
	isGuest: true

class @Maslosoft.Koe.Options extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.Options"
	selected: null

	constructor: (data = null) ->
		super data
		
class @Maslosoft.Ko.BalinDev.Widgets.MyWidget
	
	i = 0
	
	originalTitle = ''
	
	title: ''
	
	
	constructor: () ->
		@log "Create"
	
	init: (element) =>
		if not originalTitle
			originalTitle = @title
		@title = "#{originalTitle} ##{i}"
		element.innerHTML = @title
		@log "Init"
		
	dispose: (element) =>
		@log "Dispose"
		
	log: (message) =>
		i++
		jQuery('#widgetLog').append "<div>#{i}. #{message}</div>"

class @Maslosoft.Koe.Columns  extends @Maslosoft.Ko.Balin.Model

	#
	#
	# @var Maslosoft.Koe.UiColumns
	#
	columns: null

	#
	#
	# @var Maslosoft.Koe.UiColumns
	#
	sizes: null

class @Maslosoft.Koe.UiColumns extends @Maslosoft.Ko.Balin.Model

	#
	# On HD displays
	#
	# @var integer
	#
	lg: 4

	#
	# On laptops
	#
	# @var integer
	#
	md: 4

	#
	# On tablets
	#
	# @var integer
	#
	sm: 2

	#
	# On small mobile
	#
	# @var integer
	#
	xs: 2


class @Maslosoft.Ko.BalinDev.Widgets.MyOtherWidget

	i = 0

	originalTitle = ''

	title: ''


	constructor: () ->
		@log "Create other"

	init: (element) =>
		if not originalTitle
			originalTitle = @title
		if i > 1
			@title = "#{originalTitle} ##{i}"
		element.innerHTML = @title
		@log "Init other"

	dispose: (element) =>
		@log "Dispose other"

	log: (message) =>
		i++
		jQuery('#widgetLog2').append "<div>#{i}. #{message}</div>"

class @Maslosoft.Koe.CssClasses extends @Maslosoft.Ko.Balin.Model
	_class: "Maslosoft.Koe.CssClasses"
	classes: []
	classList: ''