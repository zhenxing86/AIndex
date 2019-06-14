USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[updateheight]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateheight]  
@bid int,  
@h1 varchar(50),  
@w1 varchar(50),  
@h2 varchar(50),  
@w2 varchar(50),  
@jms varchar(1000),  
@gms varchar(1000),  
@yfjz varchar(1000)  
AS  
   update BaseInfo set h1=@h1,w1=@w1,h2=@h2,w2=@w2,jibing=@jms,guomin=@gms,yfzj=@yfjz where id = @bid  
   select @@ROWCOUNT
GO
