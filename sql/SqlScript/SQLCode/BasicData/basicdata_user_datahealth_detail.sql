USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[basicdata_user_datahealth_detail]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz
-- Create date:2014-04-14
-- Description:	数据健康查询明细
--[basicdata_user_datahealth_detail] 87
-- =============================================
CREATE PROCEDURE [dbo].[basicdata_user_datahealth_detail]
@userid int
AS
BEGIN

SET NOCOUNT ON;

select u.userid,
  u.name 姓名,
  case when u.kid = 0 then lk.kid else u.kid end kid,
  case when uc.cid is null then luc.cid else uc.cid end 班级id,
  (select cname 班级 from basicdata..class where cid = (case when uc.cid is null then lk.cid else uc.cid end))班级,
  case when u.deletetag = 0 then '已删除'ELSE '未删除'end 是否删除,
  u.deletedatetime 删除时间,
  case when u.kid = 0 and lk.userid IS NOT null then '已离园'ELSE '未离园'end 是否离园,
  lk.outtime 离园时间,
   case when lk.leavereason = '12001' then '毕业离园'
        when lk.leavereason = '12002' then '转学离园'
        when lk.leavereason = '12003' then '搬迁异地'
        when lk.leavereason = '12004' then '资费原因'
        when lk.leavereason = '12005' then '资料有误彻底删除'
        when lk.leavereason = '12006' then '不详'
        else lk.leavereason end 离园原因,
    
  case when ci.[card] is null then lci.[card] else ci.[card] end 卡号,
  case when ci.usest = -2 then '作废'
       when ci.usest = -1 then '挂失'
       when ci.usest = 0 then '未开卡'
       when ci.usest = 1 then '正常使用'end 卡状态
                          
   from basicdata..[user] u
     left join mcapp..cardinfo ci
       on u.userid = ci.userid
     left join BasicData..leave_user_card lci
       on u.userid = lci.userid
     left join basicdata..leave_kindergarten lk
       on u.userid = lk.userid
     left join BasicData..user_class uc
       on u.userid = uc.userid
     left join BasicData..leave_user_class luc
       on u.userid = luc.userid
   where u.userid = @userid

END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数据健康查询明细' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'basicdata_user_datahealth_detail'
GO
