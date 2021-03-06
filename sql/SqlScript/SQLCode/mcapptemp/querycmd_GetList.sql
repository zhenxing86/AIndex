USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[querycmd_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      xie
-- Create date: 
-- Description:	
-- Memo:		
querycmd_GetList 12511,-1,-1,'2013-06-11 10:00:00','2013-07-18 10:00:00'

*/
CREATE PROCEDURE [dbo].[querycmd_GetList]
@kid int
,@devid varchar(50)
,@querytag int
,@bgndate DateTime
,@enddate DateTime
 AS 
 
 if(@kid>=0)
 begin
	if(len(@devid)>0) 
	begin
		if(@devid <>'-1')
		begin
			if(@querytag >=0)
			begin
				select kid,devid,querytag,adatetime,syndatetime,[status]  
				  FROM querycmd  
				  where kid=@kid and devid= @devid and querytag=@querytag and adatetime>=@bgndate and adatetime<=@enddate
				  order by adatetime desc
			end
			else if(@querytag =-1)
			begin
				select kid,devid,querytag,adatetime,syndatetime,[status]  
				  FROM querycmd  
				  where kid=@kid and devid= @devid and adatetime>=@bgndate and adatetime<=@enddate
				  order by adatetime desc
			end
		end
		else if (@devid ='-1')
		begin
			if(@querytag >=0)
			begin
				select kid,devid,querytag,adatetime,syndatetime,[status]  
				  FROM querycmd  
				  where kid=@kid and querytag=@querytag and adatetime>=@bgndate and adatetime<=@enddate
				  order by adatetime desc
			end
			else if(@querytag =-1)
			begin
				select kid,devid,querytag,adatetime,syndatetime,[status]  
				  FROM querycmd  
				  where kid=@kid and adatetime>=@bgndate and adatetime<=@enddate
				  order by adatetime desc
			end
		end
	end
 end 
 

GO
