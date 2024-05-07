User name	USER_ID
Mahaboob Basha	MFPL1068
Nikil R	MFPL1448
Pramija O	1014272
likhitha	1121107
ismail	MFPL1345
RAVI	1113480


------
PW 109.38-rmsdb Bn)d%2As file path for unmatching  and matching report -->/ortldbbkp/incr_bkp/xsl_gen

pw 27-app oi^el5my

pw 31-app2 Sbixa9-a 

cd $ORACLE_HOME/opmn/logs

tail -2000f reim_group~reim-oc4j-instance~default_group~1.log

tail -3000 reim_group~reim-oc4j-instance~default_group~1.log

522017326116

REIM_RESTART COMMANDS

opmnctl stopproc process-type=reim-oc4j-instance

opmnctl startproc process-type=reim-oc4j-instance

**************************
 from vendor we take Products and amount we need to pay to vendor is created by invoice and interfaced through im_doc_head and from there it is interfaced to mh_ap_posting_stage(account payable ) to ofin lmap table

and the sales, rtv, purchase,invemtory everything is from rms.mh_lmgl_interface_t table and  lmgl_interface_t@esladmin table
 rms.mh_interface_sql 

--Receipt not reflected/Check for Receipt Discrepancy and invoice  Discrepancy / unble to match invoice line status (MATCHING TEAM WILL COME WITH THIS TYPE OF ERRORS)

update im_doc_head set status='RMTCH',match_date=null where doc_id='10914623';

update im_invoice_detail set status='UNMTCH',cost_matched='N',qty_matched='N' where doc_id in('10914623');

update shipment set INVC_MATCH_STATUS='U',INVC_MATCH_DATE=null where  shipment in(7243705);

update shipsku set QTY_MATCHED=null,INVC_MATCH_STATUS='U' where shipment in('7243705');

delete from rms.im_partially_matched_receipts where shipment in('7243705');
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Records are Locked. Press view locks to view Locking details /  YOU cannot update the doc details. The document is locked by.

	delete rms.im_doc_head_lock where doc_id in('')

	delete from rms.im_receipt_lock where receipt_id in('')   --receipt_id is Shipment column of shipment table

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Invoice Deletion /  You Cannot delete Invoice with Descripancies that have been acted upon/DELETE PO ( CHECK the file invoice deletion script)

check in im_doc_head table take doc_id  using order_no 
 Using Order_no check in shipment table for shipment num 
paste it in shipment, shipsku,rms.im_partially matched lines. 

Update im_doc_head set status ='DELETE',last_update_id='ADMIN',LAST_DATETIME=Sysdate, custom_doc_ref_4='Deleted due to duplicate invoice creation by Store Team' where doc_id ='' and order_no =' '



Update im_doc_head set  status ='DELETE',last_update_id='ADMIN',LAST_DATETIME=Sysdate, custom_doc_ref_4='Deleted by the request of '
where doc_id ='' 



begin

Update im_doc_head set  status ='DELETE',last_update_id='ADMIN',LAST_DATETIME=Sysdate, custom_doc_ref_4='Deleted by the request of '
where doc_id ='' 

update shipment set INVC_MATCH_STATUS='U',INVC_MATCH_DATE=null where  shipment in(7364190);

update shipsku set QTY_MATCHED=null,INVC_MATCH_STATUS='U' where shipment in(7364190);

delete from rms.im_partially_matched_receipts where shipment in(7364190);


end;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- *if we need to delete invoice which is in posted status ** but not uploaded to financials

begin

update im_doc_head set status ='DELETE' where doc_id IN ('10893676') and order_no='8415708';

update shipment set INVC_MATCH_STATUS='U',INVC_MATCH_DATE=null where  shipment in(7364190);

update shipsku set QTY_MATCHED=null,INVC_MATCH_STATUS='U' where shipment in(7364190);

delete from rms.im_partially_matched_receipts where shipment in(7364190);

delete from mh_ap_resolved_stage where docid='7553362';

delete from mh_ap_invoice_stage where docid='7553362';

delete from mh_ap_posting_stage where header_sno='7553362'; 

end;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--In order to save this group there must be atleast one invoice or receipt

Check the status in IM_DOC_Head it should be RMTCH or URMTCH if it is in  rmtch or urmtch and check the status in shipment it should be  U is it is not u we must change .                                                                                                                                                                               

update im_invoice_detail set status='UNMTCH',cost_matched='N',qty_matched='N' where doc_id in(10939824);

update shipment set INVC_MATCH_STATUS='U',INVC_MATCH_DATE=null where  shipment in('7394854');

update shipsku set QTY_MATCHED=null,INVC_MATCH_STATUS='U' where shipment in('7394854');

delete from rms.im_partially_matched_receipts where shipment in('7394854');


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--dept/class item is not associated with business roles needed for routing

Take the receipt no -- check in the shipment table and take the item and check it in the mh_item_master_mvw.
where market and category is fetched and now using that checking in im_business_roles_dept table
now take both tables data and compare and check the missing item in im_business_roles_dept insert it
-------------------------------
select Distinct Market, Category from mh_item_master_mvw where item in(select item from shipsku where shipment='7143326' group by item)

select * from im_business_roles_dept where dept in (select Distinct Market from mh_item_master_mvw 
where item in(select item from shipsku where shipment='7143326' group by item)) and 
class in(select Category from mh_item_master_mvw where item in(select item from shipsku where shipment='7143326' group by item))

updated query to insert which are missed directly.


INSERT INTO im_business_roles_dept 
SELECT DISTINCT '1401', market, CATEGORY
           FROM mh_item_master_mvw
          WHERE item IN (SELECT   item
                             FROM shipsku
                            WHERE shipment = '9061807'
                         GROUP BY item)
            AND (market, CATEGORY) NOT IN (
                   SELECT dept, CLASS
                     FROM im_business_roles_dept
                    WHERE (dept, CLASS) IN (
                                    SELECT DISTINCT market, CATEGORY
                                               FROM mh_item_master_mvw
                                              WHERE item IN (
                                                       SELECT   item
                                                           FROM shipsku
                                                          WHERE shipment =
                                                                     '9061807'
                                                       GROUP BY item)))


--insert query
=""insert into im_business_roles_dept values('""&&""','""&&""','""&&""');""                                                             
INSERT INTO im_business_roles_dept(role_id, dept, CLASS)VALUES (1401, 51, 8147);



------------------------------------------------------------------------------------------------------------------------------------

error- No business role setup for location on document.  Location:

Then check in the below table if any roles are missed then it will popup

SELECT * FROM IM_BUSINESS_ROLES_LOC WHERE LOCATION = 50005


Then we need to inert into that table using the table  select * from im_business_roles

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--invalid id getting after running supplier tax options script
check for the user who created and if the status is s then ask the user for the reason

SELECT ORDER_NO,SUPPLIER,LOCATION,STATUS,ORIG_APPROVAL_DATE,ORIG_APPROVAL_ID FROM ORDHEAD WHERE ORDER_NO='8285810'

SELECT ORDER_NO ,   NEW_ORIG_APPROVAL_ID, OLD_ORIG_APPROVAL_ID, NEW_STATUS, OLD_STATUS, MODIFY_DATE ,CHANGE_TYPE
 FROM ORDHEAD_AU WHERE ORDER_NO='8270341'

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--to check rtv for item 

select * from rtv_head where rtv_order_no in( select rtv_order_no from rtv_detail where item in('100025957')) and store='60001' and status_ind=15



---Every financial year(JUL22-jun23 financial year ref) OFIN SidE table is purged 
--if it is done then  match date pickup in mh_inte

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--To enable vat_codes not visible for items at the time of invoice Creations.

INSERT INTO im_supplier_tax_options
/* Inserts the vat_codes that are present in Po but not available in Supplier tax options*/
   SELECT :supplier sup, vat_code
     FROM tax_assignment
    WHERE assignment_id IN (/* Takes the assignments id used at the time of po creation*/
                            SELECT DISTINCT assignment_id
                                       FROM tax_breakup
                                      WHERE tran_type = 'PO'
                                        AND tran_number = :order_no )
      AND vat_code NOT IN (/* checks the vat_codes that are already present for the vendor*/
	  SELECT tax_code
                             FROM im_supplier_tax_options
                            WHERE supplier_id = :supplier) 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PO not able to edit / Row is selected for delete. Cannot select it to edit	

"Kindly add “ http://maxrmssim1.lmggi.com:7777/reim/index.jsp” in the below path to enable row selection.
Internet Explorer -> settings -> view compatibility settings."


--Invoice copy Not reflecting in Application

-------------in mail they werre saying, even though they are uploading invoice copy, its shwoing as not uploaded

select * from im_doc_head where order_no='7203162'

select *from rms.mh_im_doc_file_path where order_no='7203162'

update rms.mh_im_doc_file_path set EXT_DOC_ID='' where order_no='' and doc_id='';

--to check join tables are proper
SELECT COUNT (1)
FROM rms.mh_im_doc_file_path a,im_doc_head b 
WHERE a.order_no = b.order_no
and a.order_no='7203162'
AND a.ext_doc_id = b.ext_doc_id


Vat Rate 	QTY	Unit_cost	SGST	CGST	Amount
9	60	113.65	613.71	613.71	6819
9	48	67.02	289.53	289.53	3216.96
9	24	141.09	304.75	304.75	3386.16
9	24	223.52	482.8	482.8	5364.48
9	30	132.59	357.99	357.99	3977.7
6	30	147.68	265.82	265.82	4430.4
2.5	32	213.72	170.98	170.98	6839.04
9	30	199.27	538.03	538.03	5978.1
9	72	271.74	1767.36	1767.36	19637.28





163866

520362



SELECT POTAX.ITEM ITEM, POTAX.VAT_CODE PO_TAX_CODE, POTAX.VAT_RATE PO_TAX_RATE, POTAX.APPLIED_ON
APPLIED_ON, POTAX.APPLICATION_ORD APPLICATION_ORD, IVDT.VAT_CODE INVOICE_TAX_CODE, IVDT.VAT_RATE
INVOICE_TAX_RATE, IVDT.VAT_BASIS, IVDT.ROWID ROW_ID FROM (SELECT TB.ITEM ITEM, TAS.VAT_CODE,
TB.VAT_RATE, TAS.APPLIED_ON, TAS.APPLICATION_ORD FROM TAX_BREAKUP TB, TAX_ASSIGNMENT TAS WHERE
TB.TRAN_NUMBER = :B2 AND (TB.TO_REF = :B1 OR TB.TO_REF IN (SELECT WH FROM WH WHERE PHYSICAL_WH=:B1 ))
AND TB.TRAN_TYPE = 'PO' AND TAS.ASSIGNMENT_ID = TB.ASSIGNMENT_ID AND TAS.VAT_CODE IN (SELECT
ISTO.TAX_CODE FROM IM_SUPPLIER_TAX_OPTIONS ISTO WHERE SUPPLIER_ID = :B3 )) POTAX, IM_INVOICE_DETAIL_TAX
IVDT WHERE IVDT.ITEM(+) = POTAX.ITEM AND IVDT.VAT_CODE(+) = POTAX.VAT_CODE AND IVDT.DOC_ID(+) = :B4
UNION ALL SELECT ITEM ITEM, NULL PO_TAX_CODE, NULL PO_TAX_RATE, NULL APPLIED_ON, NULL APPLICATION_ORD,


528223



select a.vat_code, a.vat_rate, vc.vat_code_desc from (select tas.vat_code, tas.tax_type,
vcr.vat_rate, ROW_NUMBER() OVER (PARTITION BY tas.vat_code ORDER BY activate_date desc) as
row_num, ROW_NUMBER() OVER (PARTITION BY tas.vat_code,activate_date ORDER BY active_date desc)
as row_num_2 from tax_assignment tas, im_supplier_tax_options sto, vat_code_rates vcr where
sto.supplier_id = :1 and tas.tax_type in (select tax_type from tax_type where
transaction_type_ind=:"SYS_B_0") and tas.vat_code= sto.tax_code and activate_date <= TRUNC(:2)
and NVL(inactivate_date,TRUNC(:3) + :"SYS_B_1") > TRUNC(:4) and vcr.vat_code = tas.vat_code and
vcr.active_date <= TRUNC(:5)) a,vat_codes vc where row_num = :"SYS_B_2" and row_num_2 =
:"SYS_B_3" and vc.vat_code = a.vat_code

