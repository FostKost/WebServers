var interval_id = null;
var dot_interval_id = null;
var in_progress = false;
var dot_repeat = 1;
var percent = '';
var dots = '';

function doNotClose(e) {
    var msg = 'Пожалуйста, не закрывайте страницу до окончания переноса сайта.';
    (e || window.event).originalEvent.returnValue = msg;
    return msg;
}

function ajaxCall() {
  jQuery.post("index.php?option=com_ajax&module=jino_spectrum_transfer&method=getTransferStatus&format=json", function(response) {
		stage = response.data['stage'];
		percent = response.data['percent'];
		postinst_url = response.data['postinst_url'];
		mode = response.data['mode'];

		if (percent) percent = '(' + percent + ')';

        if (mode == 'active') {
            if (stage == 'start_active_mode' && !in_progress) {
                in_progress = true;

                jQuery('#transfer-in-process').show();
                jQuery('#transfer-start').hide();
                jQuery('#transfer-finish').hide();

                startTransfer();
            }
            /*
            if (stage == 'mysqldump') startMysqlDump(secret_key);
            if (stage == 'zipall') startZipAll(secret_key, archive_num);
            if (stage == 'download') startPushZip(secret_key, archive_num, finish);
            if (stage == 'installing') startInstallZip(secret_key);
            */
        }

		if (stage == 'start_active_mode' || stage == 'mysqldump' || stage == 'zipall' || stage == 'download' || stage == 'installing') {
			if (!in_progress) {
				in_progress = true;
				if (mode == 'passive') jQuery.post("index.php?option=com_ajax&module=jino_spectrum_transfer&method=updateCPBlock&stage=" + stage + "&format=raw");

				jQuery('#transfer-in-process').show();
				jQuery('#transfer-start').hide();
				jQuery('#transfer-finish').hide();
			}
		} else {
			if (in_progress) {
				stopAjaxCheck();
                jQuery(window).off('beforeunload', doNotClose);
				in_progress = false;

				jQuery('#transfer-finish-settings')[0].href = postinst_url;

				jQuery('#transfer-in-process').hide();
				jQuery('#transfer-start').hide();
				jQuery('#transfer-finish').show();
			} else {
				jQuery('#transfer-in-process').hide();
				jQuery('#transfer-start').show();
				jQuery('#transfer-finish').hide();
			}
		}
	});
};

function updateDot() {
	if (!in_progress) return;

	dot_repeat = (dot_repeat % 3) + 1
	dots = Array(dot_repeat + 1).join('.') + Array(3 - dot_repeat + 1).join('&nbsp;')
	in_progress_text = "Идёт перенос" + dots + " " + percent;
	jQuery('#button_inprogress').html(in_progress_text);
}

function startAjaxCheck() {
	if (interval_id) return;

	interval_id = setInterval(ajaxCall, 1000);
	dot_interval_id = setInterval(updateDot, 1000);
};

function stopAjaxCheck() {
	if (!interval_id) return;

	clearInterval(interval_id); interval_id = null;
	clearInterval(dot_interval_id); dot_interval_id = null;
};

function startTransfer() {
  jQuery(window).on('beforeunload', doNotClose);
  jQuery('<p>Пожалуйста, не закрывайте страницу до окончания переноса сайта.</p>')
      .appendTo('#transfer-in-process')
      .css({
          color: '#b94a48',
          marginTop: '1em',
          marginBottom: '0',
          backgroundColor: '#f2dede',
          borderRadius: '4px',
          padding: '4px 12px',
          border: '1px solid #eed3d7'
      });
  restart_func = function() {
	setTimeout(function() {
		startTransfer();
	}, 5000);
  };

  jQuery.post("index.php?option=com_ajax&module=jino_spectrum_transfer&method=newSecretKey&format=json", function(response) {
	secret_key = response.data;

	startMysqlDump(secret_key);
  })
  .fail(restart_func);
};

function startMysqlDump(secret_key) {
  restart_func = function() {
	setTimeout(function() {
		startMysqlDump(secret_key);
	}, 5000);
  };

  jQuery.post("modules/mod_jino_spectrum_transfer/transfer.php?module=mysqldumper&joomla=1&key=" + secret_key, function(response) {
	if (response.indexOf('success') > -1) {
		startZipAll(secret_key, 1);
	} else {
		restart_func();
	}
  })
  .fail(restart_func);
};

function startZipAll(secret_key, archive_num) {
  restart_func = function() {
	setTimeout(function() {
		startZipAll(secret_key, archive_num);
	}, 5000);
  };

  jQuery.post("modules/mod_jino_spectrum_transfer/transfer.php?module=zipall&joomla=1&num=" + archive_num + "&key=" + secret_key, function(response) {
	if (response.indexOf('success') > -1) {
		startPushZip(secret_key, archive_num, finish=true);
	} else if (response.indexOf('quota') > -1) {
		startPushZip(secret_key, archive_num, finish=false);
	} else {
		restart_func();
	}
  })
  .fail(restart_func);
};

function startPushZip(secret_key, archive_num, finish) {
  restart_func = function() {
	setTimeout(function() {
		startPushZip(secret_key, archive_num, finish);
	}, 5000);
  };

  jQuery.post("modules/mod_jino_spectrum_transfer/transfer.php?module=pushzip&joomla=1&key=" + secret_key, function(response) {
	if (response.indexOf('success') > -1) {
		if (finish) {
			startInstallZip(secret_key);
		} else {
			archive_num += 1;

			startZipAll(secret_key, archive_num);
		}
	} else {
		restart_func();
	}
  })
  .fail(restart_func);
};

function startInstallZip(secret_key) {
  restart_func = function() {
	setTimeout(function() {
		startInstallZip(secret_key);
	}, 5000);
  };

  jQuery.post("modules/mod_jino_spectrum_transfer/transfer.php?module=installzip&joomla=1&key=" + secret_key, function(response) {
	if (response.indexOf('success') > -1) {
	} else {
		restart_func();
	}
  })
  .fail(restart_func);
};

//startAjaxCheck();
