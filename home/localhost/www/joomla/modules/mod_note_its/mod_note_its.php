<?php
/*
 * Note-Its
 * @author Norman "Spawnie" Malessa
 * @license GPL 2.0
 * @email norman@spawnie.net
 * @url http://www.spawnie.net/
 */

defined('_JEXEC') or die('Restricted access');

$cufon = ($params->get('cufon') == 1) ? true : false;
$font = $params->get('font');
$cufon_font = str_replace("_", " ", substr($font,0,strrpos($font,"_")));
$width = $params->get('note_width')."px";
$head = $params->get('note_head');
$headsize = $params->get('headsize')."px";
$headline_size = strval(intval($params->get('headsize'))+4)."px";
$new_window = $params->get('newwindow');
$message = $params->get('note_text');

// Line Breaks
$message = preg_replace("(\r\n|\n|\r)", "<br />", $message);

// Links
$message = str_replace('[[','<a target="'.$new_window.'" href="', $message);
$message = str_replace('##','">', $message);
$message = str_replace(']]','</a>', $message);

$size = $params->get('size')."px";
$line_size = strval(intval($params->get('size'))+4)."px";
$badge = $params->get('badge');
$color = "#".$params->get('color');
$color = str_replace("##","#",$color); // just to be sure
$separator = $params->get('separator');

require(JModuleHelper::getLayoutPath('mod_note_its'));

?>