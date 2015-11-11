<?php
// No direct access to this file
defined('_JEXEC') or die('Restricted access');
 
class mod_jino_spectrum_transferInstallerScript {
        function install($parent) {
			  $db = JFactory::getDbo();

			  $content = $db->quote(file_get_contents(dirname(__FILE__) . '/module-content.html'));
			  $params = $db->quote('{"prepare_content":"1","layout":"_:default","moduleclass_sfx":"","cache":"1","cache_time":"900","module_tag":"div","bootstrap_size":"12","header_tag":"h3","header_class":"","style":"0"}');

			  try {
				  // --------------------------
				  $q = $db->getQuery(true)
					  ->update('#__modules')
					  ->set(array('position = "cpanel"', 'showtitle=0', 'ordering=0',  'published = 1', 'content = ' . $content, 'params = ' . $params))
					  ->where("module = 'mod_jino_spectrum_transfer'");

				  $db->setQuery($q);
				  method_exists($db, 'execute') ? $db->execute() : $db->query();

				  // -------------------------
				  $q = $db->getQuery(true)
					  ->select('id')
					  ->from('#__modules')
					  ->where("module = 'mod_jino_spectrum_transfer'");
				  $db->setQuery($q);

				  $module_id = $db->loadObject()->id;

				  // -------------------------
				  $values = array($module_id, 0);

				  $q = $db->getQuery(true)
					  ->insert('#__modules_menu')
					  ->columns(array('moduleid', 'menuid'))
					  ->values(implode(',', $values));

				 $db->setQuery($q);
				 method_exists($db, 'execute') ? $db->execute() : $db->query();
			  }
			  catch (Exception $e) {
				 throw $e;
			  }
        }

        function update($parent) {
			  $db = JFactory::getDbo();

			  $content = $db->quote(file_get_contents(dirname(__FILE__) . '/module-content.html'));
			  $params = $db->quote('{"prepare_content":"1","layout":"_:default","moduleclass_sfx":"","cache":"1","cache_time":"900","module_tag":"div","bootstrap_size":"12","header_tag":"h3","header_class":"","style":"0"}');

			  try {
				  // --------------------------
				  $q = $db->getQuery(true)
					  ->update('#__modules')
					  ->set(array('position = "cpanel"', 'showtitle=0', 'ordering=0',  'published = 1', 'content = ' . $content, 'params = ' . $params))
					  ->where("module = 'mod_jino_spectrum_transfer'");

				  $db->setQuery($q);
				  method_exists($db, 'execute') ? $db->execute() : $db->query();
			  }
			  catch (Exception $e) {
				 throw $e;
			  }
        }
}
