USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[Cards_GetList]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Author:
--CreatedTime:2014/5/15
--Description:成长卡片分页列表 班级必填
------------------------------------
CREATE PROCEDURE [dbo].[Cards_GetList]
	@page int,
	@size int ,
	@grade varchar(50),
	@month int
	 AS
    declare @pcount int,@url varchar(200)
    if(@month>0)
begin
select @url=  Case @grade When '托班' Then '2-3' When '小班' Then '3-4' 
                          When '中班' Then '4-5' When '大班' Then '5-6' End + '/' + CAST(@month as Varchar) + '/'
end
else
begin
	Select @url = Case @grade When '托班' Then '2-3' When '小班' Then '3-4' 
                          When '中班' Then '4-5' When '大班' Then '5-6' End + '/%'
end
SELECT @pcount=count(1) FROM [Cards] a left join CardGroup  b on a.cgid=b.cgid where url like @url 
 
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
	SELECT  cardid  FROM [Cards] a left join CardGroup b on a.cgid=b.cgid where url like @url order by a.cardid desc

  
   SET ROWCOUNT @size   
    SELECT   
    @pcount,cardid,g.cgid, ShowDay, FestivalCard,s.ShowMonth,s.gtype,orderno FROM   
    @tmptable AS tmptable    
    INNER JOIN [Cards] g  left join 
    (select m.cgid,n.ShowMonth,m.url,n.gtype from CardGroup m left join CardSet n on m.cgid=n.cgid ) s on g.cgid=s.cgid   
    ON  tmptable.tmptableid=g.cardid   
   WHERE  
      row>@ignore  
  
end  
else  
begin  
SET ROWCOUNT @size  
select @pcount,cardid,b.cgid, ShowDay, FestivalCard,b.ShowMonth,b.gtype,orderno from Cards a left join 
(select m.cgid,n.ShowMonth,m.url,n.gtype from CardGroup m left join CardSet n on m.cgid=n.cgid ) b on a.cgid=b.cgid where url like @url order by a.cardid desc
end 
GO
