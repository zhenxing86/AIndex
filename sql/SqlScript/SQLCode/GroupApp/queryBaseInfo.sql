USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[queryBaseInfo]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: 查询基本信息  
-- =============================================  
CREATE PROCEDURE  [dbo].[queryBaseInfo]  
@bid int  
  
AS  
 select @bid bid,uc.birthday,uc.cid,uc.kid,uc.cname,uc.name as uname,uc.gender,a.term,a.checkday,  
 a.uid,a.jibing,a.guomin,a.yfzj,a.uphoto,a.month,a.weburl,a.smallPath,a.bigPath, a.h1,a.w1,a.h2,a.w2,  
 c.twcount,c.lbtcount,c.hlfycount,c.kscount,c.fscount,c.hycount,  
 c.szkcount,c.fxcount,c.pccount,c.jzjcount,c.fytxcount,c.gocount,c.zdgcCount,k.kname  
  from HealthApp..BaseInfo a  
  left join basicdata..[user_child] uc on a.uid=uc.userid  
 left join HealthApp..EndCount b on bid=@bid  
  left join HealthApp..ExceptionCount c on c.bid=@bid  
  left join BasicData..kindergarten k on k.kid = a.kid  
  where a.id = @bid  
GO
