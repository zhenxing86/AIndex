select *From mcapp..cardinfo where kid= 24170 and usest=0 order by card  and  1407104905 1407104904

select *From basicdata..class where kid= 24170

   --stuinfo_AutoSet_OneCard 24170,'98824',3,1407104905,1407104933,134
   
    stuinfo_AutoSet_OneCard_test 24170,'98824',3,1407104905,1407104933,134

select *from BasicData..User_Child where kid= 24170 and name in('���Ǽ�','������','����ŵ','Ǯ��')


userid not in (875227,875286,875307,875559,875573,875331,875337,875341,875450,875460,875463,875466,875472,875484)

  select uc.cname,uc.name,c.card,c.*    
    from CardInfo  c
    inner join basicdata..User_Child uc
     on c.userid=uc.userid     
    where usest = 1      
     and uc.kid = 24170       
     and CardType = 1 
     and CAST(cardno as bigint)>=1407104820
     and CAST(cardno as bigint)<=1407105172
     order by uc.cname,c.card
     

15028

cardinfo_BatchSet












---------------

98824	24170	С1��
98827	24170	С2��
98828	24170	С3��
98829	24170	С4��
98830	24170	С5��

98825	24170	��1��
98831	24170	��2��
98832	24170	��3��
98833	24170	��4��

98826	24170	��1��
98834	24170	��2��
98835	24170	��3��

С1��	30	29 (1407104905-1407104933)
С2��	30	30 (1407104934-1407104963)
С3��	31	29 (1407104964-1407104992)
С4��	29	27 (1407104993-1407105019)
С5��	31	30 (1407105020-1407105049)

��1��	32	32 (1407105050-1407105081)
��2��	32	32 (1407105082-1407105113)
��3��	32	30 (1407105114-1407105143)
��4��	33	29 (1407105144-1407105172)

��1��	30	30 (1407104820-1407104849)
��2��	29	29 (1407104850-1407104878) 
��3��	28	26 (1407104879-1407104904)

--stuinfo_AutoSet_OneCard 24170,'98824',3,1407104905,1407104933,134
stuinfo_AutoSet_OneCard_test 24170,'98824',3,1407104905,1407104933,134

--stuinfo_AutoSet_OneCard 24170,'98827',3,1407104934,1407104963,134
stuinfo_AutoSet_OneCard_test 24170,'98827',3,1407104934,1407104963,134

--stuinfo_AutoSet_OneCard 24170,'98828',3,1407104964,1407104992,134
stuinfo_AutoSet_OneCard_test 24170,'98828',3,1407104964,1407104992,134

--stuinfo_AutoSet_OneCard 24170,'98829',3,1407104993,1407105019,134
stuinfo_AutoSet_OneCard_test 24170,'98829',3,1407104993,1407105019,134

--stuinfo_AutoSet_OneCard 24170,'98830',3,1407105020,1407105049,134
stuinfo_AutoSet_OneCard_test 24170,'98830',3,1407105020,1407105049,134

--�а�
--stuinfo_AutoSet_OneCard 24170,'98825',3,1407105050,1407105081,134
stuinfo_AutoSet_OneCard_test 24170,'98825',3,1407105050,1407105081,134

--stuinfo_AutoSet_OneCard 24170,'98831',3,1407105082,1407105113,134
stuinfo_AutoSet_OneCard_test 24170,'98831',3,1407105082,1407105113,134

--stuinfo_AutoSet_OneCard 24170,'98832',3,1407105114,1407105143,134
stuinfo_AutoSet_OneCard_test 24170,'98832',3,1407105114,1407105143,134

--stuinfo_AutoSet_OneCard 24170,'98833',3,1407105144,1407105172,134
stuinfo_AutoSet_OneCard_test 24170,'98833',3,1407105144,1407105172,134


--���
--stuinfo_AutoSet_OneCard 24170,'98826',3,1407104820,1407104849,134
stuinfo_AutoSet_OneCard_test 24170,'98826',3,1407104820,1407104849,134

--stuinfo_AutoSet_OneCard 24170,'98834',3,1407104850,1407104878,134
stuinfo_AutoSet_OneCard_test 24170,'98834',3,1407104850,1407104878,134

--stuinfo_AutoSet_OneCard 24170,'98835',3,1407104879,1407104904,134
stuinfo_AutoSet_OneCard_test 24170,'98835',3,1407104879,1407104904,134