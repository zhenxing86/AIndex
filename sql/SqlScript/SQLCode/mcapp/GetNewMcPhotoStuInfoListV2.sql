USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[GetNewMcPhotoStuInfoListV2]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
--author: xie    
--date：2014-03-31  
--dest:获取更新了晨检照片的学生列表  
--memo:  
  
exec GetNewMcPhotoStuInfoListV2 12511,'2014-06-25'  
*/  
  
CREATE PROCEDURE [dbo].[GetNewMcPhotoStuInfoListV2]  
@kid int,     
@l_update datetime    
 AS    
begin   
    set nocount on  

	;with cet as
	(
		select u.userid,photoname,
			ROW_NUMBER()over(partition by u.userid order by mp.photoname)rowno
		 from BasicData..[user] u  
		  inner join mcapp..Mc_Photo mp 
		   on u.userid=mp.userid  
		 where u.kid = @kid 
		  and u.deletetag=1
		  and mp.photodate>=@l_update
	)
	select	userid, ISNULL([1],'') p1
					,ISNULL([2],'') p2,ISNULL([3],'') p3,ISNULL([4],'') p4 ,ISNULL([5],'') stu 
		from cet 
			pivot(max(photoname) for rowno in([1],[2],[3],[4],[5])) as p
  
end  
    
   -- select* from mcapp..driveinfo where kid = 12511 and devid='001251113'
   

GO
