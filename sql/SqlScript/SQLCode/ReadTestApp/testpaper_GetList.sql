USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[testpaper_GetList]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
------------------------------------
/*                  
memo: exec [testpaper_GetList]  1,30,35 ,'1900-01-01','2900-01-01'      
*/  
------------------------------------
CREATE PROCEDURE [dbo].[testpaper_GetList]
 @page int,            
@size int,          
@grade int =0,        
@begintime datetime='1900-01-01',
@endtime datetime='2900-01-01' ,
@title nvarchar(100)='' 
 AS 

 declare @pcount int            
           
           
   
     if(@grade>0)        
   begin        
  SELECT @pcount=count(1) FROM TestPager where grade=@grade   and isnull(pushdatetime,'1900-01-01')>=@begintime and isnull(pushdatetime,'1900-01-01')<=@endtime   and title like '%' +@title +'%'   and deletetag=1
   end         
   else        
   begin        
  SELECT @pcount=count(1) FROM TestPager     where isnull(pushdatetime,'1900-01-01')>=@begintime and isnull(pushdatetime,'1900-01-01')<=@endtime  and title like '%' +@title +'%'   and deletetag=1            
   end       

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
			if(@grade>=35 and @grade<=37)
			begin
			
				INSERT INTO @tmptable(tmptableid)
			SELECT  ID  FROM TestPager  
			where isnull(pushdatetime,'1900-01-01')>=@begintime and isnull(pushdatetime,'1900-01-01')<=@endtime and grade=@grade and deletetag=1
			 and title like '%' +@title +'%'   
			end
			else
			begin
			INSERT INTO @tmptable(tmptableid)
			SELECT  ID  FROM TestPager  
			where isnull(pushdatetime,'1900-01-01')>=@begintime and isnull(pushdatetime,'1900-01-01')<=@endtime and deletetag=1
			 and title like '%' +@title +'%'  and deletetag=1 
			end
			SET ROWCOUNT @size
			SELECT 
				@pcount  ,g.id,g.title,g.describe,g.addtime  ,g.grade,p.pushdatetime,p.url	FROM 
				@tmptable AS tmptable		
			INNER JOIN TestPager g
			ON  tmptable.tmptableid=g.ID 
			left join push p on g.id=p.testid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

 
		if(@grade>=35 and @grade<=37)
			begin
				SELECT @pcount  ,g.id,g.title,g.describe,g.addtime  ,g.grade,p.pushdatetime,p.url    		FROM
		   TestPager g  
		   	left join push p on g.id=p.testid 
		   where isnull(g.pushdatetime,'1900-01-01')>=@begintime and isnull(g.pushdatetime,'1900-01-01')<=@endtime   
		   and g.title like '%' +@title +'%'  
		   and g.grade=@grade and deletetag=1
			end
			else
			begin
	SELECT @pcount  ,g.id,g.title,g.describe,g.addtime  ,g.grade,p.pushdatetime,p.url   		FROM
		   TestPager g  
		   	left join push p on g.id=p.testid
		   where isnull(g.pushdatetime,'1900-01-01')>=@begintime and isnull(g.pushdatetime,'1900-01-01')<=@endtime   
		   and g.title like '%' +@title +'%'  and deletetag=1
		   
		end
end


GO
