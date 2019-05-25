use BasicData
go

/*
-- Author:  xzx  
-- Create date: 2014-07-30  
-- Description: ÐÞ¸ÄÃÜÂë  
demo:

dict_xml_GetList 'Ãñ×å'

*/
Create proc dict_xml_GetList
@catalog varchar(40)
as

begin
 select ID,Code,Caption,[Catalog],OrderBy
  from dict_xml 
   where [Catalog] =@catalog
end