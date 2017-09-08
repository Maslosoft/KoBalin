<?php require __DIR__ . '/../../_header.php'; ?>
<!-- trim -->
<title>Select2 Tags</title>
<h1>Select2 Tags</h1>
<p>
	<a href="https://select2.github.io/">Select2</a> is a library enchancing select element.
	This binding handler will demonstrate tags option. This binding handler also
	contains <a href="https://github.com/select2/select2/issues/861">hacks</a> required
	for tags to not pop-up empty results.
</p>
<p>
	This binding handler converts select2 to tags selector.
</p>
<h4>Live example</h4>
<p class="alert alert-warning">
	Select2 package is not bundled with this package
</p>
<!-- /trim -->
<div class="form-group">
	<select
		id="select2"
		data-bind="
			tags: balin.model.options.selected
		"
		class="form-control">
	</select>
</div>
<div data-bind="text: balin.model.options.selected"></div>
<a id="changeIt" href="#">Change programatically to [yes, no, maybe]</a>
<script>
	window.onload = (function () {

		balin.model.options = new Maslosoft.Ko.BalinDev.Models.Options();
		balin.model.options.selected = ['noisy', 'loud'];

		ko.applyBindings({model: balin.model}, document.getElementById('ko-balin'));
		// trim
		$('#changeIt').on('click', function (e) {
			var opts = ['yes', 'no', 'maybe'];
			balin.model.options.selected.removeAll();
			var i = 0;
			for (i in opts) {
				balin.model.options.selected.push(opts[i]);
			}
			e.preventDefault();
		});
		// /trim
	});
</script>

<?php require __DIR__ . '/../../_footer.php'; ?>