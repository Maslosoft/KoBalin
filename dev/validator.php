<?php require './_header.php'; ?>
<h3>
	Bootstrap styled<br />
	<small>Validates if value will change</small>
</h3>
<div data-bind="with: app.model.txt1" class="form-group">
	<label class="control-label" for="txt1">Validate input if it's only a-z:</label>
	<input class="form-control" id="txt1" data-bind="textInput: text, validator: {class: Maslosoft.Ko.BalinDev.RegExpValidator, pattern: '^[a-z]+$'}" style="width:50%;"/> <br />
</div>
<div data-bind="with: app.model.txt2" class="form-group">
	<label class="control-label" for="txt2">Validate (empty) textarea if it's only a-z:</label>
	<textarea class="form-control" id="txt2" data-bind="textInput: text, validator: {class: Maslosoft.Ko.BalinDev.RegExpValidator, pattern: '^[a-z]+$'}" style="width:50%;"></textarea> <br />
</div>
<div data-bind="with: app.model.txt3" class="form-group">
	<label class="control-label" for="txt3">Validate contenteditable if it's only a-z:</label>
	<div class="form-control" id="txt3" data-bind="htmlValue: text, validator: {class: Maslosoft.Ko.BalinDev.RegExpValidator, pattern: '^[a-z]+$'}" style="width:50%;"></div> <br />
</div>


<script>
	jQuery(document).ready(function () {
		var data1 = {
			text: 'Some Text value'
		};
		var data2 = {
			text: ''
		};
		var data3 = {
			text: 'Not valid value'
		};

		app.model.txt1 = new Maslosoft.Ko.BalinDev.Models.TextValue(data1);
		app.model.txt2 = new Maslosoft.Ko.BalinDev.Models.TextValue(data2);
		app.model.txt3 = new Maslosoft.Ko.BalinDev.Models.TextValue(data3);

		ko.applyBindings({model: app.model});
	});
</script>
<?php require './_footer.php'; ?>