USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[APPCard_GetList]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Author:
--CreatedTime:2014/5/15
--Description:手机成长卡片分页列表 班级必填
------------------------------------
create PROCEDURE [dbo].[APPCard_GetList]
	@page int,
	@size int ,
	@grade varchar(50),
	@month int
	 AS
    declare @pcount int,@gtype int

select @gtype=  Case @grade When '托班' Then 4 When '小班' Then 1
                          When '中班' Then 2 When '大班' Then 3 End

if(@month>0)
begin
SELECT @pcount=count(1) FROM AppCard where gtype=@gtype  and ShowMonth=@month
 end
 else
 begin
	SELECT @pcount=count(1) FROM AppCard where gtype=@gtype
 end
IF(@page>1)  
 BEGIN  
   
  DECLARE @prep int,@ignore int  
  
  SET @prep=@size*@page  
  SET @ignore=@prep-@size  
  
  DECLARE @tmptable TABLE  
  (  
   row int IDENTITY(1,1),  
   gtype int,
   showmonth int,
   url varchar(200)  
  )  
  
   SET ROWCOUNT @prep  

	if(@month>0)
begin
	INSERT INTO @tmptable(gtype,showmonth,url) 
	SELECT  gtype,showmonth,url  FROM AppCard where gtype=@gtype  and ShowMonth=@month order by ShowMonth desc
 end
 else
 begin
	INSERT INTO @tmptable(gtype,showmonth,url) 
	SELECT  gtype,showmonth,url  FROM AppCard where gtype=@gtype 
	order by ShowMonth desc
 end



	if(@month>0)
begin
SET ROWCOUNT @size   
    SELECT   
    @pcount,g.gtype,g.ShowMonth,g.url FROM   
    @tmptable AS tmptable    
    INNER JOIN AppCard g   
    ON  tmptable.gtype=g.gtype and tmptable.ShowMonth=g.ShowMonth and tmptable.url=g.url   
   WHERE  
      row>@ignore  and g.gtype=@gtype  and g.ShowMonth=@month
      order by ShowMonth desc
 end
 else
 begin
	SET ROWCOUNT @size   
    SELECT   
    @pcount,g.gtype,g.ShowMonth,g.url FROM   
    @tmptable AS tmptable    
    INNER JOIN AppCard g   
    ON  tmptable.gtype=g.gtype and tmptable.ShowMonth=g.ShowMonth and tmptable.url=g.url   
   WHERE  
      row>@ignore  and g.gtype=@gtype 
      order by ShowMonth desc
 end
  
   
  
end  
else  
begin  
SET ROWCOUNT @size  
if(@month>0)
begin
select @pcount,gtype,ShowMonth,url from AppCard where gtype=@gtype and ShowMonth=@month order by ShowMonth desc
 end
 else
 begin
	select @pcount,gtype,ShowMonth,url from AppCard where gtype=@gtype 
	order by ShowMonth desc
 end

end 
GO
