USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[init_kinbaseinfo]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[init_kinbaseinfo]
 AS 

insert into kinbaseinfo(
  [kid],
 [kname],
 [regdatetime],
 [ontime],
 [expiretime],
 [privince],
 [city],
 [area],
 [linkstate],
 [ctype],
 [cflush],
 [clevel],
 [parentpay],
 [infofrom],
 [developer],
 [status],
invoicetitle,
 [netaddress],
 [address],
 [remark],
  uid,abid,qq,isclosenet,mobile,[deletetag],jxsid
	)
	select kid,kname,ks.regdatetime,ks.regdatetime ontime,dateadd(dd,15,ks.regdatetime) expiretime
		,bk.privince,bk.city,area,'待跟进' linkstate,ktype ctype,'资料没上传' cflush,klevel clevel
		,'无' parentpay,dbo.infofrombycity(bk.city) infofrom
		,case when (bk.jxsnum is null or bk.jxsnum<>'0') 
			then u.ID
			else dbo.uidbycity(bk.city) end developer
		,'试用期' status,kname invoicetitle,ks.sitedns netaddress
		,ks.address,kc.memo remark
		,case when (bk.jxsnum is null or bk.jxsnum<>'0') 
			then u.ID
			else dbo.uidbycity(bk.city) end  [uid]
		,
		case when (bk.jxsnum is null or bk.jxsnum<>'0') 
			then jxs.bid
			else 
			dbo.abidbycity(bk.city) end  abid
		,ks.QQ,0,ks.phone,ks.status deletetag,jxs.ID
		 from basicdata..kindergarten bk 
			inner join kwebcms..site ks 
				on ks.siteid=bk.kid
			inner join kwebcms..site_config kc 
				on kc.siteid=bk.kid
			left join agentjxs jxs 
				on jxs.num=bk.jxsnum
			outer  apply
				(select top 1 ID from users u where jxsid=jxs.ID and u.ID<>101)
				as u
			where bk.synstatus=0

--山东代理101楚国峰（已离职）修改称119省外业务
update k set [uid]=119 ,developer=119,infofrom='代理'
	from ossapp..kinbaseinfo k 
		inner join basicdata..kindergarten bk on k.kid=bk.kid
			where abid=5 and developer =101 and bk.synstatus=0

			
--如果是分配给任丽，则取消主动分配给中幼客服经理，再做人工调整
--127：浙江省			
update k set [uid]=2,abid=0,developer=2,infofrom='客服人员' 
	from ossapp..kinbaseinfo k
		inner join basicdata..kindergarten bk on k.kid=bk.kid
	where ([uid]=102 or bk.privince=127 ) and bk.synstatus=0


--如果是代理商用户则来源是代理
update k set infofrom='代理'
	from ossapp..kinbaseinfo k 
		inner join basicdata..kindergarten bk on k.kid=bk.kid
			where abid>0  and bk.synstatus=0

--岳麓区1273自动分配给李连连132
update k set 
			infofrom='家长学校',developer=132,
			finfofrom='家长学校',abid=1,fdeveloper=0,[uid]=132
	from ossapp..kinbaseinfo k 
		inner join basicdata..kindergarten bk on k.kid=bk.kid
			where bk.area=1273  and bk.synstatus=0



update  basicdata..kindergarten set synstatus=1 where synstatus=0






	INSERT INTO [dbo].[beforefollow]
	([kid],[kname],[nature],[classcount],[provice],[city],[area],[linebus],[address]
	,[linkname],[title],[tel],[qq],[email],[netaddress],[remark],[uid],[bid],[intime]
	,[deletetag])
	 SELECT 
		  [kid],[kname]
		  ,ctype
		  ,'0'
		  ,[privince]
		  ,[city]
		  ,[area]
		  ,''
		  ,[address]
		  ,''
		  ,''
		  ,''
		  ,[qq],'',[netaddress],[remark],[uid],[abid],[regdatetime]     
		  ,[deletetag]
	  FROM [dbo].[kinbaseinfo] bk
	where bk.synstatus=0

	update [kinbaseinfo] set synstatus=1 where synstatus=0








GO
