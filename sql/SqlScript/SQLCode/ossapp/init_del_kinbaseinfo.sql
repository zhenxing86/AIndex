USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[init_del_kinbaseinfo]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[init_del_kinbaseinfo]
AS 

create table #temp
(pkid int)

insert into #temp(pkid)
select kid from dbo.kinbaseinfo where status='待删除'


INSERT INTO [dbo].[kinbaseinfo_bak]
           ([kid]
           ,[kname]
           ,[regdatetime]
           ,[ontime]
           ,[expiretime]
           ,[privince]
           ,[city]
           ,[area]
           ,[linkstate]
           ,[ctype]
           ,[cflush]
           ,[clevel]
           ,[parentpay]
           ,[infofrom]
           ,[developer]
           ,[status]
           ,[invoicetitle]
           ,[netaddress]
           ,[address]
           ,[remark]
           ,[uid]
           ,[abid]
           ,[qq]
           ,[isclosenet]
           ,[finfofrom]
           ,[fabid]
           ,[fdeveloper]
           ,[mobile]
           ,[deletetag])
select [kid]
           ,[kname]
           ,[regdatetime]
           ,[ontime]
           ,[expiretime]
           ,[privince]
           ,[city]
           ,[area]
           ,[linkstate]
           ,[ctype]
           ,[cflush]
           ,[clevel]
           ,[parentpay]
           ,[infofrom]
           ,[developer]
           ,[status]
           ,[invoicetitle]
           ,[netaddress]
           ,[address]
           ,[remark]
           ,[uid]
           ,[abid]
           ,[qq]
           ,[isclosenet]
           ,[finfofrom]
           ,[fabid]
           ,[fdeveloper]
           ,[mobile]
           ,[deletetag] from kinbaseinfo 
           inner join #temp on pkid=kid


INSERT INTO [dbo].[beforefollow_bak]
           (bfid,[kid]
           ,[kname]
           ,[nature]
           ,[classcount]
           ,[provice]
           ,[city]
           ,[area]
           ,[linebus]
           ,[address]
           ,[linkname]
           ,[title]
           ,[tel]
           ,[qq]
           ,[email]
           ,[netaddress]
           ,[remark]
           ,[uid]
           ,[bid]
           ,[mobile]
           ,[ismaterkin]
           ,[parentbfid]
           ,[childnum]
           ,[childnumre]
           ,[intime]
           ,[deletetag])
select ID,[kid]
           ,[kname]
           ,[nature]
           ,[classcount]
           ,[provice]
           ,[city]
           ,[area]
           ,[linebus]
           ,[address]
           ,[linkname]
           ,[title]
           ,[tel]
           ,[qq]
           ,[email]
           ,[netaddress]
           ,[remark]
           ,[uid]
           ,[bid]
           ,[mobile]
           ,[ismaterkin]
           ,[parentbfid]
           ,[childnum]
           ,[childnumre]
           ,[intime]
           ,[deletetag]
			from beforefollow 
           inner join #temp on pkid=kid
           

update basicdata..kindergarten set deletetag=0 from #temp where pkid=kid

update kwebcms..site set status=0 from #temp where pkid=siteid
         
delete  kinbaseinfo from #temp where pkid=kid

delete  beforefollow from #temp where pkid=kid



drop table #temp




GO
