USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[viprole]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[viprole]
	@userid int,
	@vipnum int
AS 
BEGIN
	SET NOCOUNT ON
	declare @where varchar(200)=' and 1=0'
	if(@vipnum=801) set @where=' and a2=801'
	if(@vipnum=802) set @where=' and a3=802'
	if(@vipnum=803) set @where=' and a4=803'
	if(@vipnum=804) set @where=' and a5=804'
	if(@vipnum=805) set @where=' and a6=805'
	if(@vipnum=806) set @where=' and a7=806'
	if(@vipnum=807) set @where=' and a8=807'
	if(@vipnum=808) set @where=' and a9=808'
	
	exec ('select count(1) from ossapp..addservice 
				where [uid]='+@userid+' 
					and deletetag=1 
					and describe=''开通''' +@where)
		
	
end



GO
