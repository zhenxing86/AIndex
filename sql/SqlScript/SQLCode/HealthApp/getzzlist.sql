USE HealthApp
GO
/*
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: 获取某个病症的列表
select * from mcapp..zz_dict

 exec getzzlist 43 ,5
-- =============================================  
*/
ALTER PROCEDURE [dbo].getzzlist  
	@bid int, @zzid int
AS
BEGIN      
	SET NOCOUNT ON  
	declare @uid int, @kid int, @term varchar(6), @bgn datetime, @end datetime         
  select @uid = bi.uid, @kid = kid, @term = term 
		from HealthApp..BaseInfo bi 
		where bi.id = @bid		
	
	exec CommonFun.dbo.Calkidterm @kid, @term, @bgn output,	@end output 

	select	sm.cdate, STR(sm.tw,5,2)tw
		from mcapp.dbo.stu_mc_day sm
			inner join BasicData.dbo.[user] u 
				on sm.stuid = u.userid					
		where sm.stuid = @uid 
			and sm.CheckDate >= @bgn
			and sm.CheckDate < @end
			and ',' + sm.zz + ',' like '%,'+CAST(@zzid as varchar(10))+',%'
		
END
GO