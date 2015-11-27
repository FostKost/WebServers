<?php
/*
 * Note-Its
 * @author Norman "Spawnie" Malessa
 * @license GPL 2.0
 * @email norman@spawnie.net
 * @url http://www.spawnie.net/
 */

defined('_JEXEC') or die('Restricted access');

$doc = JFactory::getDocument();
$base = JURI::base();

if($cufon) {
	$doc->addScript($base.'modules/mod_note_its/assets/js/cufon-yui.js' );
}

$doc->addScript($base.'modules/mod_note_its/assets/js/'.$font.'.font.js' );
$doc->addScriptDeclaration("Cufon.replace('div.note-its-".$module->id."', {fontFamily: '".$cufon_font."'});");
$doc->addStyleSheet($base.'modules/mod_note_its/assets/css/note_its.css' );

?>

<?php if($width > 0): ?>
<div id="note_its" style="width: <?php echo $width; ?>;">
<?php else: ?>
<div id="note_its">
<?php endif; ?>
	<?php if($badge != "no"): ?>
	<div class="<?php echo $badge; ?>"></div>
	<?php endif; ?>
<div class="npaper-top">
	<div class="npaper-top2"></div>
</div>
<div class="npaper-mid">
	<div class="npaper-mid2 nb-<?php echo $badge; ?>">
	<?php if($head != ""): ?>
	<div class="note-its-<?php echo $module->id; ?>"><h1 class="nmessage" style="line-height: <?php echo $headline_size; ?>;color: <?php echo $color; ?>;font-size: <?php echo $headsize; ?>;"><?php echo $head; ?></h1></div><br />
	<?php if($separator): ?>
		<div class="separator"></div>
	<?php endif; ?>
	<?php endif; ?>
	<div class="note-its-<?php echo $module->id; ?>"><h1 class="nmessage" style="line-height: <?php echo $line_size; ?>;color: <?php echo $color; ?>;font-size: <?php echo $size; ?>;"><?php echo $message; ?></h1></div>
        </div>
</div>
<div class="npaper-bot">
<div class="npaper-bot2">
<div class="npaper-bot3"></div>
</div>
</div>
</div>