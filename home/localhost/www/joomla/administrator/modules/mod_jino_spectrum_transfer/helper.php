<?php

defined( '_JEXEC' ) or die;

function set_config($var, $value) {
	$config_file = dirname(__FILE__) . '/config.php';
	$lines = @file($config_file);
	if (!$lines) $lines = array("<?php\n", "?>\n");
	$new_config_content = "";
	$replace = false;

	foreach ($lines as $line) {
		if (strpos($line, $var) > -1) {
			$new_line = "\t$" . $var . ' = "' . $value . '";';

			if (strpos($line, '<?php') > -1) $new_line = '<?php ' . $new_line;
			if (strpos($line, '?>') > -1) $new_line .= '?>';

			$line = $new_line . "\n";
			$replace = true;
		}
		elseif (strpos($line, '?>') > -1 and !$replace) {
			$new_config_content .= "\t$" . $var . ' = "' . $value . '";' . "\n";
		}

		$new_config_content .= $line;
	}

	file_put_contents($config_file, $new_config_content);
}

function in_process($stage) {
	$inprocess_stages = array('start_active_mode', 'mysqldump', 'zipall', 'download', 'installing');

	return in_array($stage, $inprocess_stages);
}

function get_percent($stage, $stage_since = NULL) {
	$stage_info = array(
		'start_active_mode' => array(1, 10, 2),
		'mysqldump' => array(10, 30, 29),
		'zipall' => array(30, 30, 59),
		'download' => array(60, 40, 89),
		'installing' => array(90, 110, 99),
		'finish' => array(100),
	);

	list($percent, $estimated_duration_sec, $percent_max) = $stage_info[$stage];

	if ($stage_since && $estimated_duration_sec) {
		$percent_delta = $percent_max - $percent;
		$time_now = time();
		$stage_since = min($stage_since, $time_now);
		$left_sec = max($estimated_duration_sec - ($time_now - $stage_since), 0);
		$percent_delta = $percent_delta * (($estimated_duration_sec - $left_sec) / $estimated_duration_sec);

		$percent = (int)($percent + $percent_delta);
	}

	return $percent;
}

class modJinoSpectrumTransferHelper {
    static function getAjax() {
		$app = JFactory::getApplication();
		$hostname = JURI::getInstance()->getHost();
		$version = '1.1';
		$spectrum_joomla_url = 'https://cp-spectrum.jino.ru/joomla/';

		@unlink(dirname(__FILE__) . '/config.php');
		$secret_key = self::newSecretKeyAjax();

		$app->redirect($spectrum_joomla_url . 'transfer/' . $hostname . '/' . $secret_key . '/?version=' . $version);
	}

    static function getTransferStatusAjax() {
		@include(dirname(__FILE__) . '/config.php');

		if (!$stage and $spectrum_server and $filemanager_sid) $stage = 'start_active_mode';

		list($stage, $postinst_url) = explode(' ', $stage);
		if ($app_hashid) $postinst_url = 'https://cp-spectrum.jino.ru/joomla/' . $app_hashid . '/settings/';

		if (!in_process($stage)) self::updateCPBlockAjax($stage);

		$percent = get_percent($stage, $stage_since);
		if ($percent) $percent = $percent . '%';

		$mode = $filemanager_sid ? 'active' : 'passive';

		return array('stage' => $stage, 'percent' => $percent, 'postinst_url' => $postinst_url, 'mode' => $mode);
    }

    static function newSecretKeyAjax() {
		$secret_key = uniqid();
		$secret_key_crypt = md5($secret_key);
		set_config('secret_key_crypt', $secret_key_crypt);

		return $secret_key;
    }

	static function updateCPBlockAjax($stage = '') {
		$stage_get = JRequest::getVar('stage');
		if ($stage_get) $stage = $stage_get;

		$db = JFactory::getDbo();

		if (in_process($stage)) {
			$content = $db->quote(file_get_contents(dirname(__FILE__) . '/module-content-in-process.html'));
		} else {
			$content = $db->quote(file_get_contents(dirname(__FILE__) . '/module-content.html'));
		}

		$q = $db->getQuery(true)
			  ->update('#__modules')
			  ->set(array('content = ' . $content))
			  ->where("module = 'mod_jino_spectrum_transfer'");

		$db->setQuery($q);
		method_exists($db, 'execute') ? $db->execute() : $db->query();

		return True;
	}
}

?>
