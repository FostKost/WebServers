TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER civicrm_contact_before_insert before insert ON civicrm_contact FOR EACH ROW BEGIN  \nSET NEW.created_date = CURRENT_TIMESTAMP;\n END'
sql_modes=0
definers='root@localhost'
client_cs_names='utf8'
connection_cl_names='utf8_general_ci'
db_cl_names='utf8_general_ci'
