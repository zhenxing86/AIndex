USE BasicData
GO
if OBJECT_ID('TestProc0','P') is not null
drop proc TestProc0
if OBJECT_ID('TestProc','P') is not null
drop proc TestProc
GO
CREATE PROC TestProc0
@cid bigint ,@kid bigint 
AS
select * 
from class 
where cid = @cid 
GO
EXEC TestProc0 86, null
GO
CREATE PROC TestProc
@cid bigint ,@kid bigint 
AS
select * 
from class 
where (cid = @cid or @cid is null) 
	and (kid = @kid or @kid is null)
GO
EXEC TestProc 86, null
GO


--怎么找缺失索引
dbo.gbapp.archives_error_log


--找表执行次数
VersionInfo_GetList
settlerep..rep_kin_order_sum


找出存在exec的存储过程,存在exec很容易被注入
Select distinct a.name from sys.sysobjects a, sys.syscomments b
  where a.id = b.id and ( b.text like   '%exec%')
