�
    P  ��	         	      �        �  ]�  5        //  0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           

  ^      �    h �   �k  ��h �   �j  ��A     �i	 � A     ��	 �      �  @ A     �g � A     ��	 � A     ��	 � A     ��	 � �PRIMARY�UI_contrib_trxn_id�UI_contrib_invoice_id�index_contribution_status�UI_contribution_recur_payment_instrument_id�FK_civicrm_contribution_recur_contact_id�FK_civicrm_contribution_recur_payment_token_id�FK_civicrm_contribution_recur_payment_processor_id�FK_civicrm_contribution_recur_financial_type_id�FK_civicrm_contribution_recur_campaign_id�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ���        �                  month                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   InnoDB      %                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              T                                                                                                                                                                                                                                                                87
  �	�        P   �  J)                                          id  contact_id  amount  	currency  frequency_unit 	 frequency_interval 
 installments  start_date  create_date  modified_date  cancel_date  	end_date  processor_id  payment_token_id  trxn_id  invoice_id  contribution_status_id  is_test  
cycle_day � 
	)                                          next_sched_contribution_date  failure_count  failure_retry_date  auto_renew  payment_processor_id 	 financial_type_id 
 payment_instrument_id  campaign_id  is_email_receipt 

      � 

   @   �#    B   ��4 			    �   �@     �   �% 	

 8  @   �/ 


 <  �   �l  @  `@   ;  H  `@   4  P  `�   N  X  `�   Y 	 `  `�   6 B�h   �   �y 

 g �   �X G�k  �   � D�j  �   �0 

 i	 �   �   m	 �   �  


 n	     �Q  r	 `�    

 z	 �   �v  ~	 `�     �	     �� 

 �	 �   �+ 	

 �	 �   � 


 �	 �   � 

 �	 �   �<  �	 �   �O �id�contact_id�amount�currency�frequency_unit�frequency_interval�installments�start_date�create_date�modified_date�cancel_date�end_date�processor_id�payment_token_id�trxn_id�invoice_id�contribution_status_id�is_test�cycle_day�next_sched_contribution_date�failure_count�failure_retry_date�auto_renew�payment_processor_id�financial_type_id�payment_instrument_id�campaign_id�is_email_receipt� Contribution Recur IDForeign key to civicrm_contact.id .Amount to be contributed or charged each recurrence.3 character string, value from config setting or input via user.Time units for recurrence of payment.Number of time units for recurrence of payment.Total number of payments to be made. Set this to 0 if this is an open-ended commitment i.e. no set end date.The date the first scheduled recurring contribution occurs.When this recurring contribution record was created.Last updated date for this record. mostly the last time a payment was receivedDate this recurring contribution was cancelled by contributor- if we can get access to itDate this recurring contribution finished successfullyPossibly needed to store a unique identifier for this recurring payment order - if this is available from the processor??Optionally used to store a link to a payment token used for this recurring contribution.unique transaction id. may be processor id, bank id + trans id, or account number + check number... depending on payment_methodunique invoice id, system generated or passed inDay in the period when the payment should be charged e.g. 1st of month, 15th etc.Next scheduled dateNumber of failed charge attempts since last success. Business rule could be set to deactivate on more than x failures.Date to retry failed attemptSome systems allow contributor to set a number of installments - but then auto-renew the subscription or commitment if they do not cancel.Foreign key to civicrm_payment_processor.idFK to Financial TypeFK to Payment InstrumentThe campaign for which this contribution has been triggered.if true, receipt is automatically emailed to contact on each successful payment