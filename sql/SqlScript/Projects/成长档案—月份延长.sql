
--我刚才看了2家幼儿园，家园联系册的每月进步都没有2017年1月份的，请问是默认没有的吗？现在有些幼儿园1月还在上课，需要填写的




--11、幼儿表现目录                        
 select * from ngbapp.dbo.fn_GetCellsetList('2019-0',28603)    
 select * from ngbapp.dbo.fn_GetCellsetList('2019-0',28603)                    
--12、每月进步/观察评价目录                    
 select pos,title,months from ngbapp.dbo.fn_GetMonAdvList('2019-0',28603)  
 select * from ngbapp.dbo.fn_GetMonAdvList('2019-0',28603)     


SELECT * 
--update m set cellset='1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20'
--update m set Monadvset='2,3,4,5,6'
FROM ngbapp..ModuleSet m where kid=28603 and term='2019-0'

insert into ngbapp..ModuleSet(kid, term, hbModList, gbModList, Monadvset, celltype, cellset)          
SELECT kid, term, hbModList, gbModList, '2,3,4,5,6', celltype, cellset FROM ngbapp.[dbo].fn_ModuleSet(28603,'2019-0')  

