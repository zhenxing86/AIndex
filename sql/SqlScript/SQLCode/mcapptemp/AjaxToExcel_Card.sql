USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[AjaxToExcel_Card]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      xie
-- Create date: 
-- Description:	
-- Memo:		
--1、IC卡绑定资料导出格式：  
--    卡号	卡类型	状态	用户类型	姓名	更新时间
-- exec stuinfo_GetList 1,1000,'',-1,12511,''  
-- exec AjaxToExcel_Card 12511 
*/  
CREATE PROCEDURE [dbo].[AjaxToExcel_Card]
	@kid int  
as  
BEGIN  
	select ci.cardno,
		case ci.CardType when 0 then '大卡' else '小卡' end cardtype,
		case when ci.usest= -2 then '无效卡' when ci.usest=-1 then '已挂失' 
		when ci.usest=0 then '未开卡' when ci.usest=1 and c.grade<>38 then '已开卡'  
		when ci.usest=1 and c.grade=38 then '毕业班已开卡'  end usest,
		case isnull(u.usertype,-1) when -1 then '' when 0 then '学生' else '老师' end usertype,
		u.name,
		ci.udate
		from cardinfo ci
			left join BasicData..[user] u 
				on ci.userid=u.userid and u.deletetag=1
			left join BasicData..user_class uc 
				ON u.userid = uc.userid 
			left join BasicData..class c 
				ON uc.cid = c.cid 
			where ci.kid = @kid
			order by ci.usest desc,c.grade  
	
END

GO
