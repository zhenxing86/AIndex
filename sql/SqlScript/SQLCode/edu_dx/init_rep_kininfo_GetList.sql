USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_kininfo_GetList]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_rep_kininfo_GetList]
 AS 
	SELECT 
	       [kid]    ,[kname]    ,[opentype]    ,[citytype]    ,[Kintype]    ,[gradeid]  
	         ,[gradename]    ,[cid]    ,[cname]    ,[uid]    ,[uname]  
	           ,[usertype]    ,convert(datetime,case when [birthday] is null then '1900-1-1' else [birthday] end ,120)    ,[nation]    ,[gender]    ,[areaid]    ,[areaname]    ,[u_privince]    ,[u_city]    ,[u_residence]    ,[u_mobile]    ,[t_education]    ,[t_title]    ,[t_post]    ,[t_politicalface]    ,[t_did]    ,[t_employmentform]    ,[t_kinschooltag]  
	       	 FROM [rep_kininfo]
GO
