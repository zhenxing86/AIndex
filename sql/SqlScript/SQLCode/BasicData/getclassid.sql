USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[getclassid]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[getclassid]    
@kid int,    
@classname nvarchar(100)    
as    
    
select cid from class where kid=@kid   and cname=@classname and  deletetag=1 and iscurrent =1
GO
