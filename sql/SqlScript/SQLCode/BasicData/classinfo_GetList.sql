USE BasicData
GO
/****** Object:  StoredProcedure [dbo].[classinfo_GetList]    Script Date: 12/18/2013 14:49:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      xie  
-- Create date: 2013-12-18
-- Description:  根据kid获取班级列表，及班级在校人数，离园人数 
-- Memo:    
exec classinfo_GetList 12511,1,10,'大二班'
exec classinfo_GetList 12511,1,10,''
*/   
  
alter PROCEDURE [dbo].classinfo_GetList      
@kid int, 
@page int,
@size int,        
@cname nvarchar(20)
 AS       
begin      
   DECLARE @fromstring NVARCHAR(2000)   
 
   CREATE TABLE #t(col int)
	if @cname='' or @cname is null
	begin
		insert into #t
		select cid  from class where kid = @kid
	end
	else
	begin
		insert into #t
		select cid from class where kid = @kid and cname like '%'+@cname+'%'
	end

	;with cet as
	(
		select userid, cid,1 deletetag 
		 from User_Child u
		  inner join #t t on u.cid=t.col
		union
		select l.userid, l.cid, 0 deletetag 
		 from leave_kindergarten l
		 inner join #t t on l.cid=t.col
	)

	select  cet.cid,c.cname,c.deletetag,COUNT(1) TotalCnt, SUM(cet.deletetag) InSchoolCnt 
	 into #TT
	 from class c 
	  inner join cet 
	   on cet.cid=c.cid
	 group by cet.cid,c.cname,c.deletetag
	           
 --分页查询      
 exec sp_MutiGridViewByPager      
  @fromstring ='#TT ' ,      --数据集      
  @selectstring =       
  ' cid,cname,deletetag,TotalCnt, InSchoolCnt ',      --查询字段      
  @returnstring =       
  ' cid,cname,deletetag,TotalCnt, InSchoolCnt ',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' deletetag,cname ',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @kid,   
  @S1 = @cname  
end 