USE [AppConfig]
GO
/****** Object:  StoredProcedure [dbo].[AppConfig_AppList_GetListByKidAndUserType]    Script Date: 2014/11/24 21:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AppConfig_AppList_GetListByKidAndUserType]
@kid int,
@usertype int
AS
BEGIN
  DECLARE @appkid int
  IF(@usertype=0)
  BEGIN
   SET @appkid=0
  END
  ELSE IF(@usertype=1)
  BEGIN
   SET  @appkid=1
  END
  ELSE IF(@usertype=2)
  BEGIN
   SET @appkid=2
  END

if(exists(select * from admin_app where kid=@kid))
begin
  
		 if(@usertype=2)
			begin

			select * from (

				 SELECT t1.appname,t1.controller,t1.[action],t1.appclass,t1.sort from applist as t1 inner join  kidapp t2 on t1.id=t2.appid 
				 WHERE t1.[status]<>-1 AND (t2.opkid=@appkid or opkid=@kid)
				 AND  not  exists(select  * from  tem_kidapp  where opkid=@kid AND appid=t1.id )     
				union all
				SELECT t1.appname,t1.controller,t1.[action],t1.appclass,t1.sort from applist as t1 inner join  admin_app t2 on t1.id=t2.appid 
				 WHERE t1.[status]<>-1 AND (t2.kid=@kid)
			) t
			order by sort desc    
			end
			else 
			begin
			SELECT t1.appname,t1.controller,t1.[action],t1.appclass from applist as t1 inner join  kidapp t2 on t1.id=t2.appid 
				 WHERE t1.[status]<>-1 AND (t2.opkid=@appkid or opkid=@kid)
				 AND  not  exists(select  * from  tem_kidapp  where opkid=@kid AND appid=t1.id )
			end
end
else
begin
	SELECT t1.appname,t1.controller,t1.[action],t1.appclass from applist as t1 inner join  kidapp t2 on t1.id=t2.appid 
     WHERE t1.[status]<>-1 AND (t2.opkid=@appkid or opkid=@kid)
     AND  not  exists(select  * from  tem_kidapp  where opkid=@kid AND appid=t1.id )
     order by sort desc
end
END


GO
