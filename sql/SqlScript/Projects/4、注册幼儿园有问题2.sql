
declare @siteid int =31329 ,@org_id int ,@name nvarchar(500),@site_instance_id int
select @org_id=org_id,@name = name from KWebCMS..site where siteid = @siteid 

select @site_instance_id=site_instance_id from KWebCMS_Right..sac_site_instance where org_id=@org_id

DECLARE @manage_role_id int
select @manage_role_id=role_id from KWebCMS_Right..sac_role where site_instance_id=@site_instance_id and role_name='管理员'  --site_instance_id
DECLARE @principal_role_id int
select @principal_role_id=role_id from KWebCMS_Right..sac_role where site_instance_id=@site_instance_id and role_name='园长'  --site_instance_id

select @org_id org_id ,@site_instance_id site_instance_id ,@manage_role_id manage_role_id,@principal_role_id principal_role_id
--25533	25132	75353
if isnull(@manage_role_id,0)>0
begin
	
	--select  *from kwebcms_right..sac_site_instance where site_instance_id=25132
	--select  *from kwebcms_right..sac_role where site_instance_id=25132
	--select  *from kwebcms_right..sac_role_right where role_id=75353
	
	INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
	   SELECT @manage_role_id,t4.right_id FROM KWebCMS..site t1
	    INNER JOIN kwebcms_right..sac_site_instance t2
	     ON t1.org_id=t2.org_id 
	    INNER JOIN kwebcms_right..sac_role t3
	     ON t2.site_instance_id=t3.site_instance_id
	    INNER JOIN kwebcms_right..sac_role_right t4 ON t3.role_id=t4.role_id
	     WHERE t1.siteid=20675 and t2.site_id=1 and t3.role_name='管理员' 
	      and not exists(select 1 from  KWebCMS_Right..sac_role_right s where s.role_id = @manage_role_id and  s.right_id = t4.right_id) 
end
if isnull(@principal_role_id,0)>0
begin
	INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id)
      SELECT @principal_role_id,t4.right_id FROM KWebCMS..site t1
       INNER JOIN kwebcms_right..sac_site_instance t2 ON t1.org_id=t2.org_id 
       INNER JOIN kwebcms_right..sac_role t3 ON t2.site_instance_id=t3.site_instance_id 
       INNER JOIN kwebcms_right..sac_role_right t4 ON t3.role_id=t4.role_id
        WHERE t1.siteid=20675 and t2.site_id=1 and t3.role_name='园长'  
        and not exists(select 1 from  KWebCMS_Right..sac_role_right s where s.role_id = @principal_role_id and  s.right_id = t4.right_id) 
end
