�
    0  t�         � 	      �        t  ]�  (        //                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                a       �    ( �   �   @�A     � � A     �� � �PRIMARY�UI_name�FK_civicrm_financial_account_contact_id�FK_civicrm_financial_account_parent_id�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 �          InnoDB                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    �                                                                                                                                                                                                                                                               �  ��         P     )                                          id  name  contact_id  financial_account_type_id  accounting_code 	 account_type_code 
 description  
parent_id  is_header_account  is_deductible  is_tax  	tax_rate  is_reserved  
is_active  is_default 

      � J�   @   � 

  �   �B 

 
     �$ ?�   �   �O 	=� �  �   �} 
C��  �   � 


 � �   �  � �   �z  � �   �  � �   � 	 � �   ��<  � �   �# 
 � �   �  � �   �T �id�name�contact_id�financial_account_type_id�accounting_code�account_type_code�description�parent_id�is_header_account�is_deductible�is_tax�tax_rate�is_reserved�is_active�is_default� IDFinancial Account Name.FK to Contact ID that is responsible for the funds in this accountpseudo FK into civicrm_option_value.Optional value for mapping monies owed and received to accounting system codes.Optional value for mapping account types to accounting system account categories (QuickBooks Account Type Codes for example).Financial Type Description.Parent ID in account hierarchyIs this a header account which does not allow transactions to be posted against it directly, but only to its sub-accounts?Is this account tax-deductible?Is this account for taxes?The percentage of the total_amount that is due for this tax.Is this a predefined system object?Is this property active?Is this account the default one (or default tax one) for its financial_account_type?