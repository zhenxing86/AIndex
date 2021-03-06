USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[gun_paras_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      xie
-- Create date: 2013-11-14
-- Description:	
-- Memo:		
exec gun_paras_GetList 1,10,12511,1,'-1','001251100'
exec gun_paras_GetList 2,10,-1,0,'','','大拇指','2013-10-1','2013-11-12'
*/

CREATE PROCEDURE [dbo].[gun_paras_GetList] 
 @page int,
 @size int,
 @kid int,
 @ftype int,
 @serialno nvarchar(20),
 @devid nvarchar(20),
 @kname nvarchar(50)='' ,
 @bgndate datetime= '2012-01-01',
 @enddate datetime= '9999-01-01',
 @status int=-1
 AS
BEGIN
	SET NOCOUNT ON 
	DECLARE @fromstring NVARCHAR(2000)
	
	if( @ftype=1)
	SET @fromstring = ' [mcapp].[dbo].[gun_para_xg] g inner join basicdata..kindergarten k
	on g.kid=k.kid and g.adate>=@T1 and g.adate<=@T2' 
	else 
	SET @fromstring = ' [mcapp].[dbo].[gun_para_cx] g inner join basicdata..kindergarten k
	on g.kid=k.kid and g.adate>=@T1 and g.adate<=@T2'
	 
	set @fromstring = @fromstring+' where g.[status]>-1'
	if(@kid>0) set @fromstring = @fromstring+ ' and g.kid=@D1' 
	if(@serialno!='-1' and @serialno!='') set @fromstring = @fromstring+ ' and serial_no=@S1'
	if(@devid!='-1' and @devid!='') set @fromstring = @fromstring+ ' and devid=@S2'
	if(@kname!='') set @fromstring = @fromstring+ ' and k.kname like ''%''+@S3+''%'''  
	if(@status!=-1) set @fromstring = @fromstring+ ' and g.status=@D2' 
	  
	--分页查询
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,      --数据集
		@selectstring = 
		' g.[id],g.[kid],g.[serial_no],g.[devid],g.[paras],g.[paras_values],g.[adate],g.[status],g.download_date,g.upload_date,k.kname',      --查询字段
		@returnstring = 
		' [id],[kid],[serial_no],[devid],[paras],[paras_values],[adate],[status],download_date,upload_date,kname',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = 'g.status ,g.kid,g.adate desc ',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @kid,
		@D2 = @status,
		@S1 = @serialno,
		@S2 = @devid,
		@S3 = @kname,
		@T1 = @bgndate,
		@T2 = @enddate			
		
end

GO
