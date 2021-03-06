<?php require __DIR__ . '/../_header.php'; ?>
<!-- trim -->
<title>Date Picker - Pick a Date</title>
<h1>Date Picker - Pick A Date</h1>
<p>
	Experimental date picker based on pick a date. This demo will most probably not work at all...
</p>
<p class="alert alert-danger">
	Not recommended, use <a href="../datePicker/"> datePicker</a> instead
</p>
<!-- /trim -->
<div class="input-group col-md-4 col-sm-6">
	<input data-bind="datePickerPickaDate: binder.model.datePicker.date" type="text" class="form-control"/>
</div>
<div data-bind="text: binder.model.datePicker.date">

</div>
<!-- trim -->
<p>
<br />
<a href="#" class="btn btn-success" data-bind="click: function(){binder.model.datePicker.date = Math.round(Date.now() / 1000) - 200000;}">Set a bit to past</a>
<a href="#" class="btn btn-success" data-bind="click: function(){binder.model.datePicker.date = Math.round(Date.now() / 1000);}">Set date to now</a>
<a href="#" class="btn btn-success" data-bind="click: function(){binder.model.datePicker.date = Math.round(Date.now() / 1000) + 200000;}">Set a bit to future</a>
</p>
<!-- /trim -->
<script>
	window.onload = (function(){
		binder.model.datePicker = new Maslosoft.Koe.DatePicker;
		ko.applyBindings({model: binder.model}, document.getElementById('ko-binder'));
	});
</script>
<?php require __DIR__ . '/../_footer.php'; ?>