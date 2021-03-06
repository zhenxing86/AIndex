USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollow_GetListTagOutPutForTemp]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 create PROCEDURE [dbo].[beforefollow_GetListTagOutPutForTemp]
 as
 SELECT  [kid]    ,[kname] ,[address]    ,[linkname]    
						 ,[tel]    ,[qq]      ,[netaddress]    ,[name]   
						,dbo.[getAreabyId]([provice])   
						,dbo.[getAreabyId]([city])   
						,dbo.[getAreabyId]([area])   
						,maxtime  
				FROM beforefollow kb 
					OUTER APPLY(select top(1) u.name FROM users u WHERE u.ID = kb.[uid])ca 
					OUTER APPLY(select max(intime) maxtime from dbo.beforefollowremark where bf_Id=kb.[ID] ) bf 
				where [provice]=282 and deletetag=1
				
				order by kb.[city] desc
				
--select * from BasicData..Area where Title='海南省'

--select * from BasicData..Area where ID in (58,61)

--select * from users where ID in ( 97,22)

--select * from beforefollow where  kname like '海南%' and [provice]<>282

--select * from dbo.kinbaseinfo where kid=17123

GO
