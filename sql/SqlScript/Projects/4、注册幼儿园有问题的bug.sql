
--select * from KWebCMS..site where siteid = 32953  
--select top 1 * from basicdata..[user] where  kid= 32953 and deletetag=1  and usertype=98 

--update basicdata..[user] set deletetag=1 where userid = 1573597

--select * from KWebCMS_Right..sac_site_instance where org_id=28477
--select * from KWebCMS_Right..sac_user where  org_id=28477 
--select top 1 * from basicdata..[user] where usertype=98 and deletetag=1 and kid= 32953 
--select * from site_user where  siteid = 32953 and appuserid = @userid

USE KWebCMS
GO
--select * from KWebCMS..site where siteid = 37296 
--select * from KWebCMS_Right..sac_site_instance where org_id=32800 
--select * from basicdata..department where kid=37296

declare @name nvarchar(100),@siteid int = 37296  
DECLARE @org_id int
select @org_id=org_id,@name = name from KWebCMS..site where siteid = @siteid  --org_id
if ISNULL(@org_id,0)>0
BEGIN
	-- KWebCMS..site 存在
	--select * from KWebCMS_Right..sac_org where org_id=25533
	DECLARE @site_instance_id int
	select @site_instance_id=site_instance_id from KWebCMS_Right..sac_site_instance where org_id=@org_id  --site_instance_id
	if isnull(@site_instance_id,0)=0
	begin
		INSERT INTO KWebCMS_Right..sac_site_instance(org_id,site_id,site_instance_name,personalized)
		VALUES (@org_id,1,@name+'网站后台',0)
		SELECT @site_instance_id=ident_current('KWebCMS_Right..sac_site_instance')  
	end
	
	DECLARE @manage_role_id int
	select @manage_role_id=role_id from KWebCMS_Right..sac_role where site_instance_id=@site_instance_id and role_name='管理员'  --site_instance_id
	if isnull(@manage_role_id,0)=0
	begin
		INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'管理员')
		SELECT @manage_role_id=ident_current('KWebCMS_Right..sac_role') 
	end	
	
	DECLARE @principal_role_id int
	select @principal_role_id=role_id from KWebCMS_Right..sac_role where site_instance_id=@site_instance_id and role_name='园长'  --site_instance_id
	if isnull(@principal_role_id,0)=0
	begin
		INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'园长')
		SELECT @principal_role_id=ident_current('KWebCMS_Right..sac_role') 
	end
	
	DECLARE @teacher_role_id int
	select @teacher_role_id=role_id from KWebCMS_Right..sac_role where site_instance_id=@site_instance_id and role_name='老师'  --site_instance_id
	if isnull(@teacher_role_id,0)=0
	begin
		INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'老师')
		SELECT @teacher_role_id=ident_current('KWebCMS_Right..sac_role') 
	end	
	
	DECLARE @doctor_role_id int
	select @doctor_role_id=role_id from KWebCMS_Right..sac_role where site_instance_id=@site_instance_id and role_name='医生'  --site_instance_id
	if isnull(@doctor_role_id,0)=0
	begin
		INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'老师')
		SELECT @teacher_role_id=ident_current('KWebCMS_Right..sac_role') 
	end	
	
	DECLARE @book_manage_role_id int
	select @book_manage_role_id=role_id from KWebCMS_Right..sac_role where site_instance_id=@site_instance_id and role_name='图书管理员'  --site_instance_id
	if isnull(@book_manage_role_id,0)=0
	begin
		INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'图书管理员')
		SELECT @book_manage_role_id=ident_current('KWebCMS_Right..sac_role') 
	end
	
	--DECLARE @siteid int = 29994,@org_id int =25533 ,@userid int =1572427,@account nvarchar(50)='xzyyey',@password nvarchar(100)='7C4A8D09CA3762AF61E59520943DC26494F8941B'
	DECLARE @userid int,@account nvarchar(50),@password nvarchar(100)
	select top 1 @userid=userid,@account=account,@password=password from basicdata..[user] where usertype=98 and deletetag=1 and kid= @siteid 

	if isnull(@userid,0)>0
	begin
	select 2
			DECLARE @right_userid INT 
			select @right_userid=user_id from KWebCMS_Right..sac_user where account=@account and org_id=@org_id 
			if ISNULL( @right_userid,0)=0
			begin
				INSERT INTO KWebCMS_Right..sac_user(account,password,username,createdatetime,org_id,status)  
				VALUES(@account,@password,'网站管理员',getdate(),@org_id,1)  
				
				SELECT @right_userid=ident_current('KWebCMS_Right..sac_user') 
			end
			
			if not exists ( select 1 from KWebCMS_Right..sac_user_role where user_id=@right_userid and role_id = @manage_role_id)
			begin  
				INSERT INTO KWebCMS_Right..sac_user_role(user_id,role_id) values(@right_userid,@manage_role_id)  
		    end
			declare @currentUserID int
			select @currentUserID=userid from site_user where account=@account and siteid = @siteid and appuserid = @userid
			if isnull(@currentUserID,0)=0
			begin  
				INSERT INTO site_user(siteid,account,password,name,createdatetime,usertype,UID,appuserid) VALUES(@siteid,@account,@password,'网站管理员',GETDATE(),98,@right_userid,@userid)
				SELECT @currentUserID=ident_current('site_user')   
			end
			
			  INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id) 
			   SELECT @manage_role_id,t4.right_id FROM site t1
			    INNER JOIN kwebcms_right..sac_site_instance t2
			     ON t1.org_id=t2.org_id 
			    INNER JOIN kwebcms_right..sac_role t3
			     ON t2.site_instance_id=t3.site_instance_id
			    INNER JOIN kwebcms_right..sac_role_right t4 ON t3.role_id=t4.role_id
			     WHERE t1.siteid=20675 and t2.site_id=1 and t3.role_name='管理员' 
			     			        
             INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id)
              SELECT @principal_role_id,t4.right_id FROM site t1
               INNER JOIN kwebcms_right..sac_site_instance t2 ON t1.org_id=t2.org_id 
               INNER JOIN kwebcms_right..sac_role t3 ON t2.site_instance_id=t3.site_instance_id 
               INNER JOIN kwebcms_right..sac_role_right t4 ON t3.role_id=t4.role_id
                WHERE t1.siteid=20675 and t2.site_id=1 and t3.role_name='园长'  
                
             SELECT @principal_role_id,t4.right_id FROM site t1
               INNER JOIN kwebcms_right..sac_site_instance t2 ON t1.org_id=t2.org_id 
               INNER JOIN kwebcms_right..sac_role t3 ON t2.site_instance_id=t3.site_instance_id 
               INNER JOIN kwebcms_right..sac_role_right t4 ON t3.role_id=t4.role_id
                WHERE t1.siteid=20675 and t2.site_id=1 and t3.role_name='校医'  
    end
	

    --------------- site_themesetting ----------------
	DECLARE @themeid2 int =203,@themeid int=230
	if not exists ( select * from KWebCMS..site_themesetting where siteid=@siteid)   
	INSERT INTO site_themesetting(siteid,themeid,iscurrent,styleid,themeid2) VALUES(@siteid,@themeid,1,0,@themeid2)

--delete KWebCMS..site_themesetting where siteid=32953

	--------------- site_domain ----------------
	--INSERT INTO site_domain VALUES(@currentSiteID,@sitedns)
	      
	 --创建部门可移值后面始化
	 if not exists ( select * from basicdata..department where kid=@siteid)        
	 begin
		declare @did int
		declare @did2 int
			INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
		   VALUES(@name,0,1,1,@siteid,GETDATE())
	       
		   SET @did=ident_current('basicdata..department')		
	      
		   INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])
		   VALUES('行政部',@did,1,1,@siteid,GETDATE())
	       
		   SET @did2=ident_current('basicdata..department')		
	       
		   INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('保育组',@did2,1,1,@siteid,GETDATE())
		   INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('财务组',@did2,2,1,@siteid,GETDATE())
		   INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('教学组',@did2,3,1,@siteid,GETDATE())       
		   INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('小班部',@did,4,1,@siteid,GETDATE())       
		   INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('中班部',@did,5,1,@siteid,GETDATE())       
		   INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('大班部',@did,6,1,@siteid,GETDATE())
	  end 
	     
	--创建默认班级
	if not exists ( select * from Basicdata..class where kid=@siteid)                     
		INSERT INTO Basicdata..class (kid,cname,grade,deletetag,actiondate,iscurrent,subno)
		SELECT @siteid,name,classgrade,1,getdate(),1,0 from    basicdata..Templates_Class --where classgrade=35	

		select '操作成功'

END
ELSE 
BEGIN
	select 'site 不存在，需要手动添加'
END
	



	
/*

select * from KWebCMS_Right..sac_site_instance where org_id=

SELECT * FROM  kwebcms_right..sac_site_instance where site_instance_name like '%电大%'
 
 SELECT * FROM kwebcms..site t1
               left JOIN kwebcms_right..sac_site_instance t2 ON t1.org_id=t2.org_id 
               left JOIN kwebcms_right..sac_role t3 ON t2.site_instance_id=t3.site_instance_id 
               left JOIN kwebcms_right..sac_role_right t4 ON t3.role_id=t4.role_id
                WHERE t1.siteid=1695 and t2.site_id=1 and t3.role_name='园长'  


 select  role_name,* from KWebCMS..site_user         
 left join KWebCMS_Right..sac_user u on u.[user_id]=[UID]        
 left join KWebCMS_Right..sac_user_role r on r.[user_id]=u.[user_id]        
 left join KWebCMS_Right..sac_role l on l.role_id=r.role_id        
 where appuserid=  19089 
 
   123374
   
123374

update site_user set uid=123374 where account='jxgddh' and siteid = 1695 

select * from site_user where account='jxgddh' and siteid = 1695 and appuserid = 19089
select *  from KWebCMS_Right..sac_user where org_id=22803 
select * from KWebCMS_Right..sac_user where user_id=123374

select * from KWebCMS_Right..sac_user_role where user_id=1780 and role_id = 2875

select *  from KWebCMS_Right..sac_user where org_id=22803 --account=@account and 
select * from KWebCMS_Right..sac_role where role_id = 67274

select * from KWebCMS_Right..sac_role where role_id = 67274

select * from KWebCMS_Right..sac_user_role where user_id=98127 and role_id = @manage_role_id

role_id = 67274

DECLARE @right_userid INT 
			select @right_userid=user_id from KWebCMS_Right..sac_user where org_id=22803 --account=@account and 
			if ISNULL( @right_userid,0)=0
			begin
				INSERT INTO KWebCMS_Right..sac_user(account,password,username,createdatetime,org_id,status)  
				VALUES(@account,@password,'网站管理员',getdate(),@org_id,1)  
				
				SELECT @right_userid=ident_current('KWebCMS_Right..sac_user') 
			end
			
1381404

select * from basicdata..[user] where account in('jxgddh','13576044103')

select * from BasicData..kindergarten where kid=27249
select * from BasicData..kindergarten where kid=1695

*/

go


			
