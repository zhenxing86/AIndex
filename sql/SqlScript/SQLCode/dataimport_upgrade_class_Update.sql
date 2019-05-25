USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_upgrade_class_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================    
-- Author:      
-- Project:     
-- Create date: 2014-07-17    
-- Description: 导资料升年级时候更新    
-- =============================================    
CREATE proc [dbo].[dataimport_upgrade_class_Update]    
@id int,    
@cname varchar(50),    
@newcname varchar(50),    
@newgrade varchar(50),    
@inuserid int    
as    
begin    
update excel_upgrade_class set cname=@cname,newcname=@newcname,newgrade=@newgrade,inuserid=@inuserid where id=@id  and deletetag=1    
     
end
GO
