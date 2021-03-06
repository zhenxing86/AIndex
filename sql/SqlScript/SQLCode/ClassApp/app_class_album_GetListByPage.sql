use ClassApp
go
------------------------------------      
--用途：用于班级主页webapp获取相册列表和照片列表      
--项目名称：       
--说明：      
--时间：2009-3-20 10:58:57      
-- exec app_class_album_GetListByPage 110867,1,10000     
------------------------------------      
alter proc app_class_album_GetListByPage       
@classid int,      
@page int,      
@size int      
as      
begin      
 --相册临时表      
 declare @tb_album table(albumid int,title nvarchar(200),photocount int,lastuploadtime datetime,classid int)      
 --记录总数      
 declare @pcount int      
 select @pcount=COUNT(1) from class_album where classid=@classid and [status]=1  and photocount>0       
 --IF(@page>1)      
 --BEGIN      
 -- DECLARE @prep int,@ignore int      
        
 -- SET @prep = @size * @page      
 -- SET @ignore=@prep - @size      
      
 -- DECLARE @temtable TABLE      
 -- (      
 --  --定义临时表      
 --  row int IDENTITY (1, 1),      
 --  temid bigint      
 -- )      
        
 -- SET ROWCOUNT @prep      
 -- INSERT INTO @temtable(temid)      
 --  SELECT      
 --   albumid      
 --  FROM      
 --   class_album      
 --  WHERE      
 --   classid=@classid and status=1      
 --  ORDER BY      
 --   albumid DESC       
      
 --  SET ROWCOUNT @size      
 --  insert into @tb_album(albumid,title,photocount,lastuploadtime,classid)      
 --  SELECT t2.albumid,t2.title,t2.photocount, t2.createdatetime ,t2.classid  FROM class_album t2      
              
 -- inner join @temtable t4      
 --       ON   t2.albumid=t4.temid      
 --       WHERE t2.classid=@classid AND row>@ignore    and photocount>0       
 --       ORDER BY       
 --  t2.lastuploadtime DESC      
      
 --END      
 --ELSE      
 --BEGIN      
 --  SET ROWCOUNT @size      
    insert into @tb_album(albumid,title,photocount,lastuploadtime,classid)      
   SELECT t2.albumid,t2.title,t2.photocount, t2.createdatetime ,t2.classid       
       FROM class_album t2      
        
       WHERE t2.classid=@classid  AND [status]=1  and photocount>0       
        ORDER BY       
    t2.lastuploadtime DESC      
-- END      
       
 select @pcount pcount, albumid,title,photocount,lastuploadtime,classid from @tb_album      
   
  --SET ROWCOUNT 18     
 ;With data as (    
 Select photoid,[filename],filepath,albumid,uploaddatetime,net, Row_number() Over(Partition by albumid Order by photoid Desc) RowNo    
   From class_photos Where albumid In (Select albumid From @tb_album)    
 )    
 Select photoid,[filename],filepath,albumid,uploaddatetime,net From data Where RowNo <= 3 Order by albumid desc, RowNo     
   
        
end 