USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[feestandard_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[feestandard_GetListTag]
 @page int
,@size int
,@kid int
 AS 

declare @pcount int

SELECT @pcount=count(1) FROM [feestandard] where deletetag=1   and kid=@kid 

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
			SELECT  ID  FROM [feestandard] where deletetag=1  and kid=@kid 


			SET ROWCOUNT @size
			SELECT 
				@pcount      ,[ID]    ,[kid]    ,[sname]    ,[describe]    ,[price]    ,[isproxy]    ,[proxyprice]    ,[isinvoice]    ,[uid]    ,[intime]    ,[a1]    ,[a2]    ,[a3]    ,[a4]    ,[a5]    ,[a6]    ,[a7]    ,[a8]    ,[remark]    ,[deletetag]  	
,'' astr1
,'' astr2
,'' astr3
,'' astr4
,'' astr5
,'' astr6
,'' astr7
,'' astr8
,a9,'' astr9,a10,'' astr10,a11,'' astr11,a12,'' astr12,a13,'' astr13
		FROM 
				@tmptable AS tmptable		
			INNER JOIN [feestandard] g
			ON  tmptable.tmptableid=g.ID 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount      ,[ID]    ,[kid]    ,[sname]    ,[describe]    ,[price]    ,[isproxy]    ,[proxyprice]    ,[isinvoice]    ,[uid]    ,[intime]    ,[a1]    ,[a2]    ,[a3]    ,[a4]    ,[a5]    ,[a6]    ,[a7]    ,[a8]    ,[remark]    ,[deletetag]  	
,'' astr1
,'' astr2
,'' astr3
,'' astr4
,'' astr5
,'' astr6
,'' astr7
,'' astr8
,a9,'' astr9,a10,'' astr10,a11,'' astr11,a12,'' astr12,a13,'' astr13

 FROM [feestandard]  where deletetag=1  and kid=@kid 
end


--,(select top 1 info from dbo.dict where ID=a1)
--,(select top 1 info from dbo.dict where ID=a2)
--,(select top 1 info from dbo.dict where ID=a3)
--,(select top 1 info from dbo.dict where ID=a4)
--,(select top 1 info from dbo.dict where ID=a5)
--,(select top 1 info from dbo.dict where ID=a6)
--,(select top 1 info from dbo.dict where ID=a7)
--,(select top 1 info from dbo.dict where ID=a8)


GO
