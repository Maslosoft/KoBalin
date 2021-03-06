<?php require __DIR__ . '/../_header.php'; ?>
<!-- trim -->
<title>Widget Action</title>
<h1>Widget Action</h1>
<p>
	Widget Action Binding Handler creates widget action url dynamically. The widget
	action is a standard formatted URL from <a href="/ilmatar-widgets/">Ilmatar Widgets</a>
	project to feed data-changing actions.
</p>
<!-- /trim -->
<div>
	<a href="" data-bind="widgetId: 'ms_1', action: 'sort', params: {name: 'asc'}">Action link</a><br />
	<a href="" data-bind="widget: binder.model.Widget, action: 'sort', params: {name: 'asc'}">Widget Action link</a><br />
	<a href="" data-bind="widget: binder.model.Widget, action: 'sort', params: 'sss'">Widget Action link simple param</a><br />
	<a href="" data-bind="widget: binder.model.Widget, action: 'status', params: 0">Widget Action link simple numeric param</a><br />
	<a href="" rel="tooltip" title="My tooltip" data-bind="widget: binder.model.Widget, action: 'sort'">Widget Action link no params with tooltip</a><br />
    <a href="" rel="plain" data-bind="widgetId: 'ms_1', action: 'sort', params: {name: 'asc'}">Plain link</a><br />
</div>

<script>
	window.onload = (function () {
		binder.model.Tooltip = new Maslosoft.Koe.Tooltip({title: 'This is tooltip'});
		binder.model.Widget = {
			id: 'ms_2'
		};
		ko.applyBindings({model: binder.model}, document.getElementById('ko-binder'));
		jQuery('body').tooltip({
			selector: '[rel~="tooltip"]'
		});
	});
</script>
<?php require __DIR__ . '/../_footer.php'; ?>