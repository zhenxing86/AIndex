USE [ylmysql]
GO
/****** Object:  StoredProcedure [dbo].[InitYlData]    Script Date: 2014/11/24 23:29:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:	

ALTER TABLE kwebcms..cms_content DISABLE TRIGGER Trg_cms_content
ALTER TABLE kwebcms..cms_content DISABLE TRIGGER cms_content_AspNet_SqlCacheNotification_Trigger
ALTER TABLE kwebcms..site DISABLE TRIGGER site_AspNet_SqlCacheNotification_Trigger
ALTER TABLE BlogApp..blog_posts DISABLE TRIGGER blog_posts_AspNet_SqlCacheNotification_Trigger
ALTER TABLE BlogApp..album_categories DISABLE TRIGGER album_categories_AspNet_SqlCacheNotification_Trigger
ALTER TABLE BlogApp..blog_baseconfig DISABLE TRIGGER blog_baseconfig_AspNet_SqlCacheNotification_Trigger
ALTER TABLE ClassApp.dbo.class_schedule DISABLE TRIGGER class_schedule_AspNet_SqlCacheNotification_Trigger
ALTER TABLE basicdata..[user] DISABLE TRIGGER Del_User
ALTER TABLE basicdata..[user] DISABLE TRIGGER Up_user
ALTER TABLE basicdata..Class DISABLE TRIGGER Del_Class
ALTER TABLE basicdata..Class DISABLE TRIGGER trg_class
ALTER TABLE basicdata..User_Class DISABLE TRIGGER trg_User_Class

exec InitYlData 47

ALTER TABLE basicdata..Class ENABLE TRIGGER trg_class
ALTER TABLE basicdata..Class ENABLE TRIGGER Del_Class
ALTER TABLE basicdata..[user] ENABLE TRIGGER Up_user
ALTER TABLE basicdata..[user] ENABLE TRIGGER Del_User
ALTER TABLE ClassApp.dbo.class_schedule ENABLE TRIGGER class_schedule_AspNet_SqlCacheNotification_Trigger
ALTER TABLE BlogApp..blog_baseconfig ENABLE TRIGGER blog_baseconfig_AspNet_SqlCacheNotification_Trigger
ALTER TABLE BlogApp..album_categories ENABLE TRIGGER album_categories_AspNet_SqlCacheNotification_Trigger
ALTER TABLE BlogApp..blog_posts ENABLE TRIGGER blog_posts_AspNet_SqlCacheNotification_Trigger
ALTER TABLE kwebcms..site ENABLE TRIGGER site_AspNet_SqlCacheNotification_Trigger
ALTER TABLE kwebcms..cms_content ENABLE TRIGGER Trg_cms_content
ALTER TABLE kwebcms..cms_content ENABLE TRIGGER cms_content_AspNet_SqlCacheNotification_Trigger
ALTER TABLE basicdata..User_Class ENABLE TRIGGER trg_User_Class

*/
CREATE PROC [dbo].[InitYlData]
	@yp_sId int
AS
BEGIN
	SET NOCOUNT ON
	declare @privince int, @city int, @area int, @kid int, @categoryid INT,@userid int, 
					@did int, @did2 int, @did3 int, @did4 int, @did5 int, @did6 int, @did7 int, 
					@kname  varchar(100), @yp_sUser varchar(100), @yp_sPassword varchar(100), 
					@yp_sTel varchar(100), @yp_sUrl varchar(100), @yp_sAddress varchar(100),
					@yp_sContent varchar(max), @yp_sNum INT, @themeid int, @table varchar(50)
	select @privince = ID FROM BasicData..Area where Title = '湖南省'
	select @city = ID FROM BasicData..Area where Title = '长沙市'
	select @area = ID FROM BasicData..Area where Title = '岳麓区'

	select	@kname = yp_sName, 
					@yp_sUser = yp_sUser,
					@yp_sPassword = commonfun.dbo.fn_decode(yp_sPassword), 
					@yp_sTel = yp_sTel, 
					@yp_sUrl = 'http://'+yp_sUrl, 
					@yp_sAddress = yp_sAddress, 
					@yp_sContent = yp_sContent, 
					@yp_sNum = yp_sNum
		from ylmysql.dbo.yp_schools 
		where yp_sId = @yp_sId
		
--创建幼儿园
	Begin tran   
	BEGIN TRY   
		SET @table = 'kindergarten'
		INSERT INTO BasicData..kindergarten
				(kname, address, privince, city, area, deletetag, actiondate, telephone,NGB_Descript, synstatus) 
			values(@kname, @yp_sAddress, @privince,@city,@area,1,'2014-01-01', @yp_sTel,'岳麓区批量导入', @yp_sId)     
		SET @kid = ident_current('BasicData..kindergarten') 
--	PRINT 'kindergarten'
		--插入园所简介
		SELECT @categoryid = categoryid 
			FROM kwebcms..cms_category 
			where siteid = 0 
				and categorycode = 'YSJJ'
		SET @table = 'cms_content'
		insert into kwebcms..cms_content
			(	categoryid, [content], title, titlecolor, author, createdatetime, 
				searchkey, searchdescription, browsertitle, viewcount, commentcount,  
				status, siteid, draftstatus)                      
			VALUES(@categoryid, @yp_sContent, '园所简介', '#000000', 
							'幼儿园管理员', GETDATE(), '园所简介','园所简介', 
							'园所简介', 0, 0,  1, @kid, 0)   


		SET @table = 'department'
		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES(@kname,0,1,1,@kid,GETDATE())  
			SET @did = ident_current('BasicData..[department]') 
		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('行政部',@did,1,1,@kid,GETDATE()) 
			SET @did2 = ident_current('BasicData..[department]')  
		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('保育组',@did2,1,1,@kid,GETDATE())  
			SET @did6 = ident_current('BasicData..[department]')  
		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('财务组',@did2,2,1,@kid,GETDATE()) 
			SET @did7 = ident_current('BasicData..[department]')   
		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('教学组',@did2,3,1,@kid,GETDATE())
			SET @did5 = ident_current('BasicData..[department]')             
		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('小班部',@did,2,1,@kid,GETDATE())
			SET @did3 = ident_current('BasicData..[department]')            
		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('中班部',@did,3,1,@kid,GETDATE())          
		INSERT INTO basicdata..department([dname],[superior],[order],[deletetag],[kid],[actiondatetime])VALUES('大班部',@did,4,1,@kid,GETDATE())  


		SET @table = '[user]管理员'	
	 INSERT INTO basicdata..[user]
			 (account,password,usertype,deletetag,
			 regdatetime,kid,name,nickname,birthday,gender,nation,mobile,
			 email,address,enrollmentdate,headpic,IsNeedTransferPassword) 
		--新建管理员		   
		SELECT	case when exists(select * from BasicData..[user] u where u.account = ys.yp_sUser And u.deletetag = 1) 
						then yp_sUser+LEFT(newid(),10) else yp_sUser END,
						@yp_sPassword,98,1,getdate(),@kid,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),
						'AttachsFiles/default/headpic/default.jpg',1 
			FROM ylmysql.dbo.yp_schools ys 
			where yp_sId = @yp_sId  		  
		SET @userid = ident_current('basicdata..[user]')
	--PRINT 'user'
		SET @table = 'teacher'	
		   
		INSERT INTO basicdata..teacher(userid,did,title)values(@userid,@did,'管理员') 
	--PRINT 'teacher'

		------------------ site ----------------  
	 DECLARE @site_instance_id int, @org_id int
		SET @table = 'sac_org'	
	 INSERT INTO KWebCMS_Right..sac_org(org_name,create_datetime,up_org_id) VALUES(@kname,getdate(),0)  
	 SELECT @org_id=ident_current('KWebCMS_Right..sac_org')  
	 -- @org_id = 16942
		 --创建网站表  
		SET @table = 'site'	
		INSERT INTO KwebCMS..site(siteid,name,description,address,sitedns,provice,city,regdatetime,      
			phone,accesscount,status,org_id,keyword)         
		 VALUES(@kid,@kname,@kname,@yp_sAddress,@yp_sUrl,@privince,      
			@city,GETDATE(), @yp_sTel,@yp_sNum,1,@org_id,@kname) 
--	PRINT '' 
		SET @table = 'sac_site_instance'		 
	 INSERT INTO KWebCMS_Right..sac_site_instance(org_id,site_id,site_instance_name,personalized)  
	 VALUES (@org_id,1,@kname+'网站后台',0)  
	 SELECT @site_instance_id=ident_current('KWebCMS_Right..sac_site_instance')  
		SET @table = 'sac_role'  
	 DECLARE @manage_role_id int  
	 INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'管理员')  
	 SELECT @manage_role_id=ident_current('KWebCMS_Right..sac_role')  
	 DECLARE @principal_role_id int  
	 INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'园长')  
	 SELECT @principal_role_id=ident_current('KWebCMS_Right..sac_role')    
	 DECLARE @teacher_role_id int  
	 INSERT INTO KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)VALUES(1,@site_instance_id,'老师')  
	 SELECT @teacher_role_id=ident_current('KWebCMS_Right..sac_role')    
	  
		SET @table = 'sac_role_right'   
			INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id)   
		 SELECT @manage_role_id,right_id FROM kwebcms_right..gly_right_id WHERE siteid=1027  
		 INSERT INTO KWebCMS_Right..sac_role_right(role_id,right_id)   
		 SELECT @principal_role_id,right_id FROM kwebcms_right..yz_right_id WHERE siteid=1027  
--	PRINT 'right' 
	 
		 select TOP(1) @themeid = themeid from kwebcms..site_themelist where theme_category_id=2 and siteid=0 ORDER BY NEWID() 
	               
		--幼儿园配置表   
		SET @table = 'site_config'                      
		INSERT INTO KWebCMS.dbo.site_config      
			(siteid,shortname,code,memo, smsnum,ispublish,isportalshow,      
			 kindesc,copyright,guestopen,isnew,ptshotname,isvip,isvipcontrol,      
			 ispersonal,denycreateclass,classtheme,kinlevel,kinimgpath,theme,      
			 bbzxaccount,bbzxpassword,classphotowatermark,linkman,status)      
		 VALUES(@kid,@kname,'','创典家长学校合作幼儿园（岳麓区教育局）',10,0,0,'','',0,0,@kname,0,0,0,0,'','','',@themeid,'','','',@kname,1)       
	--PRINT 'site_config'  
	  
		SET @table = 'site_themesetting'             
		INSERT INTO KWebCMS.dbo.site_themesetting(siteid,themeid,iscurrent,styleid,themeid2)       
		 VALUES(@kid,@themeid,1,0,203)       
		INSERT INTO KWebCMS.dbo.site_domain(siteid,domain)       
		 VALUES(@kid,@yp_sUrl)     
	  
	 ------------ kin_friendhref ----------------  
		SET @table = 'kin_friendhref'  
	 INSERT INTO KWebCMS.dbo.kin_friendhref(caption,href,siteid,orderno)  
	 SELECT caption,href,@kid,orderno FROM KWebCMS.dbo.kin_friendhref WHERE siteid=1026 ORDER BY id  
	 
	 --创建班级 
		SET @table = 'class'    
	 INSERT INTO Basicdata..class (kid,cname,grade,deletetag,actiondate,iscurrent,subno)  
	 SELECT @kid,yp_cname,
					case 
						when yp_cName like '%毕业%' THEN 38 
						when yp_cName like '%大%' then 37 
						when yp_cName like '%中%' then 36 
						ELSE 35 END,1,getdate(),1,yp_cId 
	 from  ylmysql..yp_classes 
	 where yp_sId = @yp_sId   
--	PRINT 'class'  

		SET @table = '[user]小朋友重复帐号'    
	INSERT INTO BasicData..[user](account,password,usertype,deletetag,regdatetime,kid,name,nickname,birthday,gender,nation,  
				 mobile,email,address,enrollmentdate,headpic,headpicupdate,enrollmentreason,network,IsNeedTransferPassword)
	SELECT	yp_User + LEFT(newid(),10), commonfun.dbo.fn_decode(yp_Password), 0, 1, GETDATE(),@kid, yp_Name,yp_Name, 
					CASE WHEN ISDATE(yp_Age) = 1 THEN yp_Age ELSE NULL END,
					CASe yp_Sex when 1 then 3 else yp_Sex end, 0, case when ISNUMERIC(yp_User) = 1 AND LEN(yp_User) = 11 then yp_User else yp_Jmobile END,
								yp_Email, null, GETDATE(), yp_Pic,'2007-10-02 10:00','岳麓区批量导入',yp_Id,1  
			FROM ylmysql..yp_users yu 
			where yp_sId = @yp_sId
			and exists(select * from BasicData..[user] u where u.account = yu.yp_User and u.deletetag = 1)
				and yu.yp_User <> '' 

		SET @table = '[user]小朋友无重复帐号'    
	;with cet as
	(
	SELECT	yp_User account, commonfun.dbo.fn_decode(yp_Password) password, 0 usertype, 
					1 deletetag, GETDATE() regdatetime,@kid kid, yp_Name name,yp_Name nickname,
					CASE WHEN ISDATE(yp_Age) = 1 THEN yp_Age ELSE NULL END birthday,
					CASe yp_Sex when 1 then 3 else yp_Sex end gender, 0 nation,
					case when ISNUMERIC(yp_User) = 1 AND LEN(yp_User) = 11 then yp_User else yp_Jmobile END mobile,
					yp_Email email, GETDATE()enrollmentdate, yp_Pic headpic,'岳麓区批量导入' enrollmentreason,yp_Id network,
					ROW_NUMBER()OVER(PARTITION by yp_User order by getdate())rowno 
			FROM ylmysql..yp_users yu 
			where yp_sId = @yp_sId
			and NOT exists(select * from BasicData..[user] u where u.account = yu.yp_User and u.deletetag = 1) 
				and yu.yp_User <> '' 
	)
	INSERT INTO BasicData..[user](account,password,usertype,deletetag,regdatetime,kid,name,nickname,birthday,gender,nation,  
				 mobile,email,enrollmentdate,headpic,headpicupdate,enrollmentreason,network,IsNeedTransferPassword)
	select account,password,usertype,deletetag,regdatetime,kid,name,nickname,birthday,gender,nation,  
				 mobile,email,enrollmentdate,headpic,'2007-10-02 10:00',enrollmentreason,network,1
				 from cet 
				 where rowno = 1
	
--	PRINT 'user1'       
		SET @table = 'child'    
		 insert into BasicData..child(userid,fathername,mothername,favouritething,  
									fearthing,favouritefoot,footdrugallergic)    
			 select userid,'','','','','',''
				from  BasicData..[user] 
				where kid = @kid
					and usertype = 0
--	PRINT 'child'     
	 		     
	 --user_class 
		SET @table = 'user_class'  
	 INSERT INTO BasicData..user_class(cid, userid)    
	 select c.cid, u.userid  
		from BasicData..[user] u
			inner join ylmysql..yp_users yu
				on u.network = yu.yp_Id
			inner join BasicData..class c
				on yu.yp_cId = c.subno
				and c.kid = @kid
			where u.kid = @kid
				and u.usertype = 0  
--	PRINT 'user_class'     
		
		SET @table = '[user]老师重复帐号'   
	;with cet as
	(
	SELECT	yp_tUser + LEFT(newid(),10) account, commonfun.dbo.fn_decode(yp_tPassword)password, 
					case when yu.yp_pId = 1 then 97 else 1 end usertype, 1 deletetag, GETDATE() regdatetime,@kid kid,
								yp_tName name, yp_tName nickname, null birthday, CASe yp_tSex when 1 then 3 else yp_tSex end gender, 0 nation,
								case when ISNUMERIC(yp_tUser) = 1 AND LEN(yp_tUser) = 11 then yp_tUser else null END mobile,
								null email,GETDATE() enrollmentdate, yp_tPic headpic, '岳麓区批量导入' enrollmentreason,yp_tId network,
					ROW_NUMBER()OVER(PARTITION by yp_tUser order by getdate())rowno   
					FROM ylmysql..yp_teachers yu 
				where yp_sId = @yp_sId   
					and exists(select * from BasicData..[user] u where u.account = yu.yp_tUser and u.deletetag = 1)		
				and yu.yp_tUser <> '' 
	)
	INSERT INTO BasicData..[user](account,password,usertype,deletetag,regdatetime,kid,name,nickname,birthday,gender,nation,  
				 mobile,email,enrollmentdate,headpic,enrollmentreason,network,IsNeedTransferPassword)
	select account,password,usertype,deletetag,regdatetime,kid,name,nickname,birthday,gender,nation,  
				 mobile,email,enrollmentdate,headpic,enrollmentreason,network,1
				 from cet 
				 where rowno = 1	

		SET @table = '[user]老师无重复帐号'   		
	INSERT INTO BasicData..[user](account,password,usertype,deletetag,regdatetime,kid,name,nickname,birthday,gender,nation,  
				 mobile,email,enrollmentdate,headpic,enrollmentreason,network,IsNeedTransferPassword)
	SELECT	yp_tUser, commonfun.dbo.fn_decode(yp_tPassword), case when yu.yp_pId = 1 then 97 else 1 end, 1, GETDATE(),@kid,
								yp_tName,yp_tName,null,	CASe yp_tSex when 1 then 3 else yp_tSex end, 0,
								case when ISNUMERIC(yp_tUser) = 1 AND LEN(yp_tUser) = 11 then yp_tUser else null END mobile,
								null,GETDATE(), yp_tPic, '岳麓区批量导入' ,yp_tId, 1  
					FROM ylmysql..yp_teachers yu 
				where yp_sId = @yp_sId   
					and NOT exists(select * from BasicData..[user] u where u.account = yu.yp_tUser and u.deletetag = 1) 		
				and yu.yp_tUser <> ''	 
	--PRINT 'user2'     

		SET @table = 'teacher'   			
		insert into BasicData..teacher(userid,did,title,post,education,employmentform,politicalface)    
			 select userid,
							case yt.yp_pId 
							when 1 then @did 
							when 2 then @did2 
							when 3 then @did3 
							when 4 then @did3 
							when 5 then @did5 
							when 6 then @did6 
							when 7 then @did7 end,
							CASE WHEN yp.yp_pName = '班主任' then '主班老师' ELSE ISNULL(yp.yp_pName,'') END,'','','',''
				from  BasicData..[user] u
					inner join ylmysql..yp_teachers yt on u.network = yt.yp_tId AND yt.yp_sId = @yp_sId
					left join ylmysql..yp_positions yp on yt.yp_pId = yp.yp_pId
				where kid = @kid
					and usertype > 0		 
--	PRINT 'teacher'     		



	CREATE TABLE #sac_user(right_userid int,account varchar(100),password varchar(100),username varchar(100))     
	 --------------- site_user ------------------  
		SET @table = 'sac_user'   	
	 INSERT INTO KWebCMS_Right..sac_user(account,password,username,createdatetime,org_id,status) 
	 output inserted.[user_id],inserted.account,inserted.password,inserted.username
	 into #sac_user(right_userid,account,password,username)
	 SELECT account, password,name,GETDATE(),@org_id,1 
	 FROM BasicData..[USER] 
	 WHERE usertype > 0 and kid = @kid  		 
	--PRINT 'sac_user'     		 
	 
		SET @table = 'sac_user_role'   	
	 INSERT INTO KWebCMS_Right..sac_user_role(user_id,role_id)  
		select  su.right_userid, 
						CASE u.usertype WHEN 98 then @manage_role_id when 97 then @principal_role_id else @teacher_role_id end
		 from #sac_user su 
		 inner join BasicData..[user] u 
		 on su.account = u.account 
		 and u.usertype > 0 
		 and u.kid = @kid  
		 and u.deletetag = 1 
--	PRINT 'sac_user_role'     		 
		   
		SET @table = 'site_user'  
	 INSERT INTO KWebCMS..site_user(siteid,account,password,name,createdatetime,usertype,UID,appuserid) 
	 select @kid, u.account, u.password, u.name, GETDATE(),u.usertype, su.right_userid,u.userid 
	 from #sac_user su 
		 inner join BasicData..[user] u 
		 on su.account = u.account 
		 and u.usertype in (97,98) 
		 and u.kid = @kid  
		 and u.deletetag = 1
	--PRINT 'site_user'   

		SET @table = 'user_class'  
	 INSERT INTO BasicData..user_class(cid, userid)    
	 select c.cid, u.userid  
		from BasicData..[user] u
			inner join ylmysql..yp_powers yp on u.network = yp.yp_tId
			inner join BasicData..class c
				on yp.yp_cId = c.subno
			where u.kid = @kid
				and u.usertype > 0  
				and c.kid = @kid  
--	PRINT 'user_class'   
					
	 --新增user_bloguser
		SET @table = 'user_bloguser'  
	 INSERT INTO BasicData..user_bloguser(userid)
		select userid
			from  BasicData..[user] 
			where kid = @kid	
	--PRINT 'user_bloguser'   
	    
	declare @Categoryid1 int, @Categoryid2 int, @Categoryid3 int, @Categoryid4 int 
		select @Categoryid1 = categoryid
			from KWebCMS..cms_category 
			where categorycode = 'gg'	
				and siteid = 0
		select @Categoryid2 = categoryid
			from KWebCMS..cms_category 
			where categorycode = 'xw'	
				and siteid = 0
		select @Categoryid3 = categoryid
			from KWebCMS..cms_category 
			where categorycode = 'ZSZL'	
				and siteid = 0
		select @Categoryid4 = categoryid
			from KWebCMS..cms_category 
			where categorycode = 'MZSP'	
				and siteid = 0
		
		SET @table = 'cms_content' 		 		
		insert into kwebcms..cms_content
			(categoryid, [content], title, titlecolor, author, createdatetime, 
			searchkey, searchdescription, browsertitle, viewcount, commentcount,  
			status, siteid, draftstatus)     
			SELECT	CASE yp_lId WHEN 1 THEN @Categoryid1 WHEN 2 THEN @Categoryid2 WHEN 3 THEN @Categoryid3 WHEN 4 THEN @Categoryid4 END,
							yp_nContent, yp_nTitle, '#000000', '幼儿园管理员', yp_mTime, yp_nTitle,yp_nTitle,yp_nTitle, 0, 0, 1, @kid, 0 
				FROM ylmysql..yp_news 
				WHERE yp_sId = @yp_sId
					and yp_lId in(1,2,3,4)  	 
	--PRINT 'cms_content'   

	 
		SET @table = 'Honours' 		
	INSERT INTO BlogApp..Honours(userid, kid, hName, hOwner, hRank, hGrade, hOrgan, hTime, hType, hUnit, hTeacher, hPic, rylei)
	select	ub.bloguserid, u.kid, yb.yp_thName, yb.yp_thOwner, 
					yb.yp_thRank, yb.yp_thGrade, yb.yp_thOrgan, yb.yp_thTime, 
					yb.yp_thType, yb.yp_thUnit, yb.yp_thTeacher, yb.yp_thPic, yb.yp_rylei
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	inner join ylmysql..yp_thonours yb on u.network = yb.yp_tId
	where u.kid = @kid and u.usertype > 0
	 
		SET @table = 'blog_postscategories默认' 		
	insert into BlogApp..blog_postscategories([userid],[title],[description],[displayorder],[postcount])  
	select ub.bloguserid, '默认分类','',0,0  
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	where u.kid = @kid	 

	   
	--初始化列表     
		SET @table = 'blog_postscategories小朋友' 		
	 INSERT INTO BlogApp..blog_postscategories([userid],[title],[description],[displayorder],[postcount])  
	select ub.bloguserid, CAST(yb.yp_blName AS NVARCHAR(30)),'',yb.yp_blId,0  
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	inner join ylmysql..yp_blists yb on u.network = yb.yp_Id
	where u.kid = @kid and u.usertype = 0
	--VALUES(@userid,'个人日记','',1,1)  
	--PRINT 'blog_postscategories'   
 	  
		SET @table = 'blog_posts小朋友' 	
	 insert into BlogApp..blog_posts([author],[userid],[postdatetime],[title],[content],[poststatus],[categoriesid],
	 [commentstatus],[IsTop],[IsSoul],[postupdatetime],[commentcount],[viewcounts],[smile]) 
	 select u.name, ub.bloguserid, yb.yp_bdTime,CAST(yb.yp_bdTitle AS NVARCHAR(30)),yb.yp_bdContent,1,bp.categoresid,1,1,0,yb.yp_bdTime,0,0,'1' 
	 from  BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	inner join ylmysql..yp_bdiarys yb on u.network = yb.yp_Id
	inner join BlogApp..blog_postscategories bp on ub.bloguserid = bp.userid and bp.displayorder = yb.yp_blId
	where u.kid = @kid and u.usertype = 0  
	--PRINT 'blog_posts'   
	  
	--新增相册默认分类 

		SET @table = 'album_categories默认' 	
	INSERT INTO BlogApp..album_categories(  
	[userid],[title],[description],[displayorder],[albumdispstatus],[photocount],[createdatetime],deletetag  
	)
	 select ub.bloguserid, '默认分类','',0,0,0, GETDATE(),1  
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	where u.kid = @kid 

		SET @table = 'album_categories' 	
	INSERT INTO BlogApp..album_categories(  
	[userid],[title],[description],[displayorder],[albumdispstatus],[photocount],[createdatetime]  
	)
	 select ub.bloguserid, yb.yp_bbplName,'',yb.yp_bbplId,0,0, GETDATE()  
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	inner join ylmysql..yp_bbplists yb on u.network = yb.yp_Id
	where u.kid = @kid and u.usertype = 0
	--PRINT 'album_categories'   

		SET @table = 'album_photos' 	
	 insert into BlogApp..album_photos( categoriesid, title, filename, filepath, filesize, 
	 viewcount, commentcount, uploaddatetime, iscover, isflashshow, orderno, deletetag, net) 
	 select ac.categoriesid, CAST(yb.yp_bbpContent AS NVARCHAR(100)) , yb.yp_bbpUrl, '', 0, 
	 0, 0, yb.yp_bbpTime, 0, 0, 1, 1, 31
	 from  BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	inner join ylmysql..yp_bbpics yb on u.network = yb.yp_Id and yb.yp_sId = @yp_sId
	inner join BlogApp..album_categories ac on ub.bloguserid = ac.userid and ac.displayorder = yb.yp_bbplId
	where u.kid = @kid and u.usertype = 0 
--	PRINT 'album_photos'    

		SET @table = 'Video_Categories默认' 
--ylmysql..yp_bvlists
	INSERT INTO BlogApp..Video_Categories(userid,Title,displayorder)
	 select ub.bloguserid, '默认分类', 0  
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	where u.kid = @kid 

		SET @table = 'Video_Categories' 
	INSERT INTO BlogApp..Video_Categories(userid,Title,displayorder)
		select ub.bloguserid, yb.yp_bvlName,yb.yp_bvlId  
			from BasicData..user_bloguser ub 
				inner join BasicData..[user] u on ub.userid = u.userid 
				inner join ylmysql..yp_bvideos bv on bv.yp_Id = u.network
				inner join ylmysql..yp_bvlists yb on yb.yp_bvlId = bv.yp_bvlId
			where u.kid = @kid and u.usertype = 0
			GROUP BY ub.bloguserid, yb.yp_bvlName,yb.yp_bvlId
--	PRINT 'Video_Categories'   

		SET @table = 'Videos小朋友' 
	insert into BlogApp..Videos(Categoriesid,Title,CoverPic,PicNet,ViewCNT,VideoUrl,VideoUpdateTime,VideoNet) 
		select vc.categoriesid, CAST(bv.yp_bvTitle AS VARCHAR(50)), bv.yp_bvPpath, 31, bv.yp_bvNum, bv.yp_bvPath, bv.yp_bvTime, 0
			from  BasicData..user_bloguser ub 
				inner join BasicData..[user] u on ub.userid = u.userid 
				inner join ylmysql..yp_bvideos bv on bv.yp_Id = u.network 
				inner join BlogApp..Video_Categories vc on ub.bloguserid = vc.userid and vc.displayorder = bv.yp_bvlId
			where u.kid = @kid and u.usertype = 0 
--	PRINT 'Videos'  
	
	--ylmysql..yp_tvideos
		SET @table = 'Videos老师' 
	insert into BlogApp..Videos(Categoriesid,Title,CoverPic,PicNet,VideoUrl,VideoUpdateTime,VideoNet) 
		select vc.categoriesid, CAST(yt.yp_tvTitle AS VARCHAR(50)), yt.yp_tvPpath, 31, yt.yp_tvPath, yt.yp_tvTime, 0
			from  BasicData..user_bloguser ub 
				inner join BasicData..[user] u on ub.userid = u.userid 
				inner join ylmysql..yp_tvideos yt on yt.yp_tId = u.network 
				inner join BlogApp..Video_Categories vc on ub.bloguserid = vc.userid and vc.displayorder = 0
			where u.kid = @kid and u.usertype > 0 
--	PRINT 'Videos'  	 

	;with CET as
	(
	select v.categoriesid,COUNT(1)CNT,MAX(v.CoverPic)CoverPic 
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid
	inner join BlogApp..Video_Categories vc on ub.bloguserid = vc.userid 
	inner join BlogApp..Videos v on vc.categoriesid = v.categoriesid
	where u.kid = @kid
	GROUP BY v.categoriesid
	)
	update vc set	CoverPic = c.CoverPic,
				PicNet = 31
		 from BlogApp..Video_Categories vc 
	 inner join CET c on vc.categoriesid = c.categoriesid	
	 
	  
	--新增默认博客留言  
		SET @table = 'blog_messageboard' 
	INSERT INTO BlogApp..blog_messageboard(  
	[userid],[fromuserid],[author],[content],[msgstatus],[msgdatetime],[parentid]  
	)
	select ub.bloguserid, -1,'中国幼儿园门户','<h2>亲爱的'+u.name+'小朋友：</h2><p class="f13" style="color:#386952">真高兴,咱们幼儿园又多了一位小朋友加入进来了!为了帮助你快速了解小朋友成长档案提供的各项功能, 我们为你提供了详细的功能介绍，详细请点击<a href="http://www.zgyey.com/blogfaq.html" target="_blank" ><font color="red">帮助中心</font></a>。</p><h3>特别提示:</h3><p>如果你在使用中遇到问题, 你可以选择:<br>1.请与在线客服人员联系，<em><strong>在线客服QQ:</strong>4006011063</em> <br>2.发信至中国幼儿园门户<em><strong>客服信箱:</strong> zgyey@zgyey.com</em> <br><font class="f13">别忘了常来到成长档案看看写写哦！</font><br><font class="f13">老师和其他小朋友一起在这里和你分享成长中的趣事！</font><br><font class="f13">我们将为孩子在幼儿园的生活增添更多乐趣和切实的帮助!</font></p></p>',0,getdate(),0
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	where u.kid = @kid and u.usertype = 0
	--PRINT 'blog_messageboard'    

	  
	--新增博客默认配置表  
	 
		SET @table = 'blog_baseconfig'  
	INSERT INTO BlogApp..blog_baseconfig(  
	[userid],[blogtitle],[description],[defaultdispmode],[postdispcount],[themes],
	[messagepref],[postscount],[albumcount],[photocount],[visitscount],[createdatetime],  
	[updatedatetime],[lastposttitle],[blogtype],[blogurl],[integral],[kininfohide],
	[posttoclassdefault],[commentpermission],[openblogquestion],[openbloganswer],
	[messagepermission],[postviewpermission],[albumviewpermission]  
	)
	select ub.bloguserid,u.name+'',CAST(yu.yp_Info AS VARCHAR(8000)),0,5,3,0,1,1,0,yu.yp_Num,getdate(),getdate(),  
	'我的成长档案开通啦',1,'http://blog.zgyey.com/'+rtrim(convert(char(10),ub.bloguserid))+'/index.html',0,0,0,1,'','',1,0,0  
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	INNER JOIN ylmysql..yp_users yu on yu.yp_Id = u.network and yu.yp_sId = @yp_sId
	where u.kid = @kid and u.usertype = 0
	--PRINT 'blog_baseconfig'    
	   
	--初始化列表    
	
		SET @table = 'blog_postscategories老师'  
	INSERT INTO BlogApp..blog_postscategories
		(	[userid],[title],[description],[displayorder],[postcount])  
		select ub.bloguserid, CAST(yb.yp_tlName AS NVARCHAR(30)),'',yb.yp_tlId,0  
			from BasicData..user_bloguser ub 
				inner join BasicData..[user] u on ub.userid = u.userid 
				inner join ylmysql..yp_tlists yb on u.network = yb.yp_tId
			where u.kid = @kid and u.usertype > 0
	--PRINT 'blog_postscategories'    
	 
		SET @table = 'blog_posts老师'  
	 insert into BlogApp..blog_posts(
						[author],[userid],[postdatetime],[title],[content],[poststatus],[categoriesid],
						[commentstatus],[IsTop],[IsSoul],[postupdatetime],[commentcount],[viewcounts],[smile]) 
	 select CAST(u.name AS NVARCHAR(20)), ub.bloguserid, yb.yp_tdTime,CAST(yb.yp_tdTitle AS NVARCHAR(30)),
					yb.yp_tdContent,1,bp.categoresid,1,1,0,yb.yp_tdTime,0,0,'1' 
	 from  BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	inner join ylmysql..yp_tdiarys yb on u.network = yb.yp_tId 
	inner join BlogApp..blog_postscategories bp on ub.bloguserid = bp.userid and bp.displayorder = yb.yp_tlId
	where u.kid = @kid and u.usertype > 0  
	--PRINT 'blog_posts'    
	 
	--新增相册默认分类  

		SET @table = 'album_categories老师'  
	INSERT INTO BlogApp..album_categories(  
	[userid],[title],[description],[displayorder],[albumdispstatus],[photocount],[createdatetime],deletetag  
	)
	 select ub.bloguserid, yb.yp_ttplName,'',yb.yp_ttplId,0,0, GETDATE(),1  
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	inner join ylmysql..yp_ttplists yb on u.network = yb.yp_tId
	where u.kid = @kid and u.usertype > 0
--	PRINT 'album_categories'    

		SET @table = 'album_photos老师'  
	 insert into BlogApp..album_photos( categoriesid, title, filename, filepath, filesize, 
	 viewcount, commentcount, uploaddatetime, iscover, isflashshow, orderno, deletetag, net) 
	 select ac.categoriesid, yb.yp_ttpContent, yb.yp_ttpUrl, '', 0, 
	 0, 0, yb.yp_ttpTime, 0, 0, 1, 1, 31
	 from  BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	inner join ylmysql..yp_ttpics yb on u.network = yb.yp_tId and yb.yp_sId = @yp_sId
	inner join BlogApp..album_categories ac on ub.bloguserid = ac.userid and ac.displayorder = yb.yp_ttplId
	where u.kid = @kid and u.usertype > 0 
--	PRINT 'album_photos'     


	--新增默认博客留言  
		SET @table = 'blog_messageboard老师'  
	INSERT INTO BlogApp..blog_messageboard(  
	[userid],[fromuserid],[author],[content],[msgstatus],[msgdatetime],[parentid]  
	)
	select ub.bloguserid, -1,'中国幼儿园门户','<h2>尊敬的'+u.name+'老师：</h2><p class="f13" style="color:#386952">欢迎你加入到中国幼儿园门户，为本班小朋友建立一个温馨的班级家园！与全国幼教同行们一起沟通交流!</p><p class="f13"style="color:#386952">为了帮助你快速了解中国幼儿园门户老师教学助手提供的各项功能, 我们为你提供了详细的功能介绍，详细请点击<a href="http://www.zgyey.com/blogfaq.html" target="_blank" ><font color="red">帮助中心</font></a>。</p><h3>特别提示:</h3><p>如果你在使用中遇到问题, 你可以选择:<br>1.请与在线客服人员联系，<em><strong>在线客服QQ:</strong>4006011063</em> <br>2.发信至中国幼儿园门户<em><strong>客服信箱:</strong> zgyey@zgyey.com</em> </p><p class="f13">我们会随时准备为你提供帮助,并将以最快的速度加以改进。</p><p class="f13">希望我们能为您提供更多切实的帮助!</p></p>',0,getdate(),0
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	where u.kid = @kid and u.usertype > 0
--	PRINT 'blog_messageboard'     
	 
	--新增博客默认配置表   
		SET @table = 'blog_baseconfig老师'     
	INSERT INTO BlogApp..blog_baseconfig(  
	[userid],[blogtitle],[description],[defaultdispmode],[postdispcount],[themes],
	[messagepref],[postscount],[albumcount],[photocount],[visitscount],[createdatetime],  
	[updatedatetime],[lastposttitle],[blogtype],[blogurl],[integral],[kininfohide],
	[posttoclassdefault],[commentpermission],[openblogquestion],[openbloganswer],
	[messagepermission],[postviewpermission],[albumviewpermission]  
	)
	select ub.bloguserid,u.name+'',CAST(yu.yp_tInfo AS VARCHAR(8000)),0,5,3,0,1,1,0,yu.yp_tNum,getdate(),getdate(),  
	'我的教学助手开通啦',1,'http://blog.zgyey.com/'+rtrim(convert(char(10),ub.bloguserid))+'/index.html',0,0,0,1,'','',1,0,0  
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid 
	INNER JOIN ylmysql..yp_teachers yu on yu.yp_tId = u.network --and yu.yp_sId = @yp_sId
	where u.kid = @kid and u.usertype > 0
--	PRINT 'blog_baseconfig'     

	;with CET as
	(
	select p.categoriesid,COUNT(1)CNT 
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid
	inner join BlogApp..blog_postscategories bp on ub.bloguserid = bp.userid 
	inner join BlogApp..blog_posts p on bp.categoresid = p.categoriesid
	where u.kid = @kid
	GROUP BY p.categoriesid
	)
	 update bp set postcount = c.CNT
	 from BlogApp..blog_postscategories bp 
	 inner join CET c on bp.categoresid = c.categoriesid
	 
	;with CET as
	(
	select p.categoriesid,COUNT(1)CNT,MAX(p.filename)filename 
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid
	inner join BlogApp..album_categories bp on ub.bloguserid = bp.userid 
	inner join BlogApp..album_photos p on bp.categoriesid = p.categoriesid
	where u.kid = @kid
	GROUP BY p.categoriesid
	)
	update bp set photocount = c.CNT,
				coverphoto = c.filename,
				net = 31,
				coverphotodatetime = GETDATE()
		 from BlogApp..album_categories bp 
	 inner join CET c on bp.categoriesid = c.categoriesid
	
	;with CET as
	(
	select ub.bloguserid,COUNT(1)CNT
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid
	inner join BlogApp..album_categories bp on ub.bloguserid = bp.userid 
	where u.kid = @kid
	GROUP BY ub.bloguserid
	)
	update bb set albumcount = c.CNT
		 from BlogApp..blog_baseconfig bb 
	 inner join CET c on bb.userid = c.bloguserid	
	 
	 	;with CET as
	(
	select ub.bloguserid,COUNT(1)CNT
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid
	inner join BlogApp..album_categories bp on ub.bloguserid = bp.userid 
	inner join BlogApp..album_photos p on bp.categoriesid = p.categoriesid
	where u.kid = @kid
	GROUP BY ub.bloguserid
	)
	update bb set photocount = c.CNT
		 from BlogApp..blog_baseconfig bb 
	 inner join CET c on bb.userid = c.bloguserid	
	 
	;with CET as
	(
	select ub.bloguserid,COUNT(1)CNT
	from BasicData..user_bloguser ub 
	inner join BasicData..[user] u on ub.userid = u.userid
	inner join BlogApp..blog_postscategories bp on ub.bloguserid = bp.userid 
	inner join BlogApp..blog_posts p on bp.categoresid = p.categoriesid
	where u.kid = @kid
	GROUP BY ub.bloguserid
	)
	update bb set postscount = c.CNT
		 from BlogApp..blog_baseconfig bb 
	 inner join CET c on bb.userid = c.bloguserid
	
	
		SET @table = 'class_schedule'  
	insert into ClassApp.dbo.class_schedule(title, userid, author, classid, kid, [content], createdatetime, viewcount, commentcount, ShareType) 
	select ye.yp_elTitle, u.userid, u.name, c.cid, @kid, ye.yp_elContent, ye.yp_elTime, 0, 0, yp_eltype 
	from ylmysql..yp_elessons ye 
	inner join BasicData..[User] u 
	on ye.yp_tId = u.network 
	and u.usertype > 0 
	and u.kid = @kid
	inner join BasicData..class c on c.kid = @kid and c.subno = ye.yp_cId
	where ye.yp_sid = @yp_sid
--	PRINT 'class_schedule'     

		SET @table = 'kinbaseinfo'  
insert into ossapp..kinbaseinfo(  
  [kid],[kname],[regdatetime],[ontime],[expiretime], [privince],  
 [city],[area], [linkstate],  [ctype], [cflush],  [clevel], [parentpay],  
 [infofrom], [developer], [status], invoicetitle, [netaddress],  
 [address], [remark], uid,abid,qq,isclosenet,mobile,[deletetag]  
 )  
 select bk.kid,bk.kname,ks.regdatetime,ks.regdatetime ontime,dateadd(dd,15,ks.regdatetime) expiretime  
  ,bk.privince,bk.city,area,'待跟进' linkstate,ktype ctype,'资料没上传' cflush,klevel clevel  
  ,'无' parentpay,ossapp.dbo.infofrombycity(bk.city) infofrom  
  ,ossapp.dbo.uidbycity(bk.city)  developer  
  ,'试用期' status,kname invoicetitle,ks.sitedns netaddress  
  ,ks.address,kc.memo remark  
  , ossapp.dbo.uidbycity(bk.city) [uid]  
  , ossapp.dbo.abidbycity(bk.city)   abid  
  ,ks.QQ,0,ks.phone,ks.status deletetag  
   from basicdata..kindergarten bk   
   inner join kwebcms..site ks   
    on ks.siteid=bk.kid  
   inner join kwebcms..site_config kc   
    on kc.siteid=bk.kid  
   where bk.kid=@kid  
	--PRINT 'kinbaseinfo'   
	
		SET @table = 'blog_classlist'  
INSERT INTO KWebCMS..blog_classlist(siteid,classid)
select kid,cid from BasicData..class where kid = @kid	
		SET @table = 'T_DictionarySetting'  
insert into KWebCMS..T_DictionarySetting(kid,dic_id) values (@kid,35),  (@kid,36),  (@kid,37)	   
exec BasicData..BoxStatusEdit @Kid = @Kid, @StatusNo = 1	

		Commit tran                              
	End Try      
	Begin Catch 
		select @yp_sid yp_sid, @table 表,error_message() as 错误消息,
					 error_severity() as 严重级别,
					 error_state() as state;	     
		Rollback tran  
	end Catch  
	select @kid
END

GO
