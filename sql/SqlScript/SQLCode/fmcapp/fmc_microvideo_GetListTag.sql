USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[fmc_microvideo_GetListTag]    Script Date: 06/18/2013 18:06:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：获取专家讲坛信息
--项目名称：家庭教育中心 com.zgyey.fmcapp.cms  
--说明: 
--时间：2013-6-17 15:50:29
--exec fmc_microvideo_GetListTag '幼儿成长','幼儿成长专题','sfsadfdsaf','http://www.hao123.com/',123,'2013-06-17 10:00:00',1
------------------------------------
ALTER PROCEDURE [dbo].[fmc_microvideo_GetListTag]
 @page int
,@size int
AS 

declare @pcount int

SELECT @pcount=count(1) FROM [fmc_microvideo] where deletetag =1

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size
		
		if(@pcount<@ignore)
		begin
			set @page=@pcount/@size
			if(@pcount%@size<>0)
			begin
				set @page=@page+1
			end
			SET @prep=@size*@page
			SET @ignore=@prep-@size
		end

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT  ID  FROM [fmc_microvideo] 

		SET ROWCOUNT @size
		SELECT @pcount,[ID],title,describe,smallimg,url,[uid],intime,click,deletetag
		  FROM  @tmptable AS tmptable		
		  INNER JOIN [fmc_microvideo] g
		  ON  tmptable.tmptableid=g.ID and g.deletetag=1
		  WHERE row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT  @pcount,[ID],title,describe,smallimg,url,[uid],intime,click,deletetag
  FROM [fmc_microvideo] g 
  where g.deletetag=1
end




