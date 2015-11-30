TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER civicrm_address_after_insert after insert ON civicrm_address FOR EACH ROW BEGIN  \nUPDATE civicrm_contact SET modified_date = CURRENT_TIMESTAMP WHERE id = NEW.contact_id;\n END' 'CREATE DEFINER=`root`@`localhost` TRIGGER civicrm_address_after_update after update ON civicrm_address FOR EACH ROW BEGIN  \nUPDATE civicrm_contact SET modified_date = CURRENT_TIMESTAMP WHERE id = NEW.contact_id;\n END' 'CREATE DEFINER=`root`@`localhost` TRIGGER civicrm_address_after_delete after delete ON civicrm_address FOR EACH ROW BEGIN  \nUPDATE civicrm_contact SET modified_date = CURRENT_TIMESTAMP WHERE id = OLD.contact_id;\n END'
sql_modes=0 0 0
definers='root@localhost' 'root@localhost' 'root@localhost'
client_cs_names='utf8' 'utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8_general_ci' 'utf8_general_ci' 'utf8_general_ci'
