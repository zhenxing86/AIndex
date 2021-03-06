USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_ReClear]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Deletetag
------------------------------------
CREATE PROCEDURE [dbo].[kinbaseinfo_ReClear]
@kid int
 AS 
 begin transaction


--还原幼儿之前要注意，如果一些以前已经删除的，要注意是否全部还原，还是还原这次删除的。
update basicdata..[user] set deletetag=1 where kid=@kid and DATEDIFF(dd,deletedatetime,GETDATE())=0

update kwebcms..site set status=1 where siteid=@kid
update basicdata..kindergarten set deletetag=1,synstatus=0 where kid=@kid


insert into kwebcms..site_domain (siteid,domain)
select siteid,sitedns from kwebcms..[site] where siteid=@kid


declare @org_id int,@site_instance_id int,@role_id int,@UID int
select @org_id=org_id from kwebcms..[site] where siteid=@kid 
select @site_instance_id=site_instance_id from kwebcms_right..sac_site_instance where org_id=@org_id
select @role_id=role_id from kwebcms_right..sac_role where site_instance_id= @site_instance_id and role_name='管理员'
select @UID=[user_id] from kwebcms_right..sac_user_role where role_id=@role_id

insert into kwebcms..site_user(siteid,createdatetime,[UID],appuserid,usertype)
select kid,GETDATE(),@UID,userid,usertype from  basicdata..[user] where kid=@kid and usertype=98


if @@ERROR>0
    begin
      
        rollback transaction
    end
else
    begin
        
        commit transaction
    end

GO
