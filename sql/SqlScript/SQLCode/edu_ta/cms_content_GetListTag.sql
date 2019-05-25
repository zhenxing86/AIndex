USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_GetListTag]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--鐢ㄩ€旓細鏌ヨ璁板綍淇℃伅 
--椤圭洰鍚嶇О锛?
--璇存槑锛?
--鏃堕棿锛?012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[cms_content_GetListTag]
 @page int
,@size int
,@firsttime datetime
,@lasttime datetime
,@title varchar(100)
,@catid int
 AS 


if(@firsttime = '')
BEGIN
set @firsttime=convert(datetime,'1900-01-01')
End


if(@lasttime = '')
BEGIN
set @lasttime=convert(datetime,'2090-01-01')
End

declare @pcount int

set @lasttime=dateadd(day,1,@lasttime)

SELECT @pcount=count(1) FROM [cms_content] where deletetag=1 and catid=@catid and intime >@firsttime and intime <= @lasttime	and title like '%'+@title+'%'

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT  contentid  FROM [cms_content] where deletetag=1 and catid=@catid and intime >@firsttime and intime <= @lasttime	and title like '%'+@title+'%'  order by intime desc


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,contentid    ,catid    ,title    ,content    ,inuserid    ,intime    ,deletetag    ,gid  			FROM 
				@tmptable AS tmptable		
			INNER JOIN [cms_content] g
			ON  tmptable.tmptableid=g.contentid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,contentid    ,catid    ,title    ,content    ,inuserid    ,intime    ,deletetag    ,gid  	 FROM [cms_content] g where deletetag=1 and catid=@catid and intime >@firsttime and intime <= @lasttime	and title like '%'+@title+'%'  order by intime desc
end







GO
