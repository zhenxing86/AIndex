参考博客：
<a href='https://www.cnblogs.com/linjiqin/archive/2013/11/02/3403095.html'> https://www.cnblogs.com/linjiqin/archive/2013/11/02/3403095.html</a><br/>

<a href='https://mp.weixin.qq.com/s/m29yJ50pSRT10qYow8o3wQ'>新人自学Java路线（包含书籍推荐）</a><br/>
如果能为初学者更多详细的指点，我也很乐意去做，这次我又更新了一些新的内容.有兴趣的可以往下看。然后就是，总有人问学不学docker、hadoop、spark、hbase、服务治理等等。

这里我做一个统一答疑,这些东西真不是你一个刚学习Java的人该看的,也不是你工作第一年应该去看的东西,不要总在某些地方看到一些词就跟风.技术这门活,你入行了就会发现,还有更广阔的技术栈,更多的开源项目,每年都有新花样,想学熟练的地步,就第一阶段花一年时间学都不为过。

如果你是一个遇见困难望而却步的人，那么我建议你不用接着看下去了。真的不用因为Java前景好，上升空间大就来学习它。如果你是一个逻辑思维比较强的，喜欢有挑战性的工作的话，那么学习编程方面的技能对你来说会比较合适！

------------------------------------------update1------------------------------------------

1年前写的回答了，看到好多人还是在问从哪里开始学习适不适合之类的，我觉得还是把答案改改，写清楚点儿吧。

------------------------------------------update--------------------------------------------

其实Java并没有想象中的那么难，首先想要入这个行，要做好一个心理准备，那就是你想走远点，就得不间断的去学习，去汲取知识，前期不能怕辛苦，不要闲下来就打LOL、吃鸡、王者农药，有空就得多看看各种开源项目的代码，API的设计方式，各大网站的设计架构，理解各个环节的作用。补齐自己的知识视野。

当然这个行业也并不是什么门槛都没有，不要再私信我初中生、高中生、中专生能不能学习Java了。反正我个人是认为不可行的，或许你可以去问问其他大神？ 或许他们会觉得可以的。

下图是我更新过的自学表，分别分为4个阶段。按照这四个阶段平稳的去学习并在每一个阶段做完相应的项目和练习,找一份工作是完全没有问题的 。当然，这里有个前提是你能学的下去，且通过查看网上的资料或视频能起码看得懂第一阶段的内容。如果第一阶段全职学习耗时2个月以上的话，我个人建议你就需要仔细考虑考虑是否真的要人这个行业吧。因为这个时间节点还没能够搞明白第一阶段的内容的话，从我个人的经验来讲可能后续走起来会更加吃力。




2018年10月8日17:59:44


Java学习前的一些准备
JDK - （Java SE Development Kit）

JDK是Java开发所需要的环境，就跟我们想玩某个网游一样，玩之前一定是需要先安装相应的程序包的。 那这个JDK就是我们准备登陆Java大陆前需要安装的一个程序包。

下载地址 ： Java SE - Downloads
IDE - (Integrated Development Environmen)

IDE是集成开发环境，一般集成开发环境都会带有JDK，可以使用自带的JDK也可以使用我们下载的JDK，不同的IDE配置不同。Java常用的IDE有Eclipse、MyEclipse、IntelliJ IDEA。IDE具备代码分析、补全、变异、调试等常用功能，可以大大的提高开发人员的编程效率。

eclipse下载地址  ： https://www.eclipse.org/downloads/
MyEclipse下载地址 ： MyEclipse官方中文网
IntelliJ IDEA ： IntelliJ IDEA: The Java IDE for Professional Developers by JetBrains
书籍推荐

《Head First Java(中文版)(第2版)(涵盖Java5.0)》 塞若, 贝茨【摘要 书评 试读】图书www.amazon.cn

《Java编程思想(第4版)》 埃史尔, 陈昊鹏【摘要 书评 试读】图书www.amazon.cn

阶段大致细节
1、入门基础
Java简介

了解什么是Java；代码语法基本格式；输出表达式。

了解Java大致的编译以及执行过程

Java语言基础、循环、数组 ; 了解类和对象

掌握Java的基本数据类型和引用数据类型有哪些；

掌握强制数据类型转换和自动类型提升规则；

常量如何声明及赋值；

循环的语法及作用；

数组的声明及定义；

掌握类的概念以及什么是对象。

OOP封装、继承、多态

面向对象的三大特征，本节内容非常重要也相对来说较为难以理解，一定要耐下心来好好理解。

java.util.*包下的常用类

util包下的Collection、Comparator、Iterator、List、Map、Set接口都很重要，着重看一下他们的实现类，如：ArrayList、LinkedList、HashSet、HashMap、Hashtable、TreeMap、TreeSet等。

java.lang.*包下的常用类

lang包下的基本数据类型对应的包装类（Byte、Short、Integer、Long、Double、Float、Character、Boolean）；

字符串相关的类String、StringBuffer、StringBuilder。

IO流操作,多线程及Socket

掌握IO读写流相关的类，了解字节流，字符流和字符流缓冲区；

掌握线程的概念，多线程的创建、启动方式，锁和同步的概念及运用；

掌握Socket通信的概念，如何声明客户端服务端，如何完成双端数据通信。

泛型、数据库基础(Mysql)及JDBC

到了数据库前,我们可以看看泛型以及反射的一些基础案例

掌握数据库的基本概念，Mysql的安装、启动与停止

Mysql数据库客户端的安装与使用

JDBC的概念，在Java中使用Mysql驱动包连接Mysql

Mysql社区版下载 : Download MySQL Community Server
客户端连接工具 Navicat for Mysql下载 : MySQL Database Administration and Development Tool
      通过第一阶段的学习掌握Java语法和常用类，数据库入门技术相关知识。让自己对于存储，IO，这些有个大概的了解。这时候，暂时不需要花大量的精力以及篇幅去学习多线程和Socket，当然这里不是说他们不重要，而是对于现阶段的你，或许很难非常清晰的明白以及了解他们具体的作用。这里第一节忽略掉了Swing，Swing章节的内容可以不学，因为在实际的工作中基本上没有用武之地。

       使用第一阶段的技术完成一个小型的系统，找一个自己做容易理解的系统练练手，比如超市管理系统、成绩管理系统等等这类需求简单却能讲整章内容结合起来使用的项目。当然这个时候可能会有人觉得没有图形界面没法完成系统操作。实际上我们可以通过Console的输入输出来做系统界面。

     新手在第一阶段的学习时，是最难熬的，因为这个时候需要背的东西特别多，且不再像看小说一样，什么东西都能看明白。路就变成了前面熟悉，左右陌生。这个时候人的求知欲作祟，往往会把自己带着偏移了方向，因为我们自己也不知道这样走对不对。渐而远之，也就慢慢放弃了。而这样的放弃，是最不值得的。所以，学习Java一定要按照某一个大纲，一直往下不要往其他地方偏，先走完一遍之后，再回头慢慢捡。

2、前端基础
HTML基本标签、表格、表单和框架；

掌握网页的基本构成;

掌握HTML的基本语法;

表格的作用以及合并行、合并列；

表单标签的使用，提交方式get/post的区别;

框架布局的使用

CSS样式表；

掌握CSS的语法及作用，在html中的声明方式；

掌握CSS布局的函数使用；

掌握CSS外部样式的引入。

JavaScript；

掌握JS的语法及作用，在HTML中的声明方式；

掌握JS的运行方式；

掌握JS中的变量声明、函数声明、参数传递等；

掌握HTML中的标签事件使用;

掌握JS中的DOM原型

上述三节都可以查看w3school : HTML 系列教程
jQuery

了解如何使用jQuery，下载最新版或者老版本的jQuery.js

掌握选择器、文档处理、属性、事件等语法及使用；

能够灵活使用选择器查找到想要查找的元素并操作他们的属性；

动态声明事件；

动态创建元素。

jQuery文档 ： jQuery API 中文文档 | jQuery API 中文在线手册 | jquery api 下载 | jquery api chm
BootStrap；

掌握BootStrap的设计理念，以及使用方式。这是我们需要接触的第一个前端框架，使用起来也很简单；

掌握BootStrap的栅格系统、表单、全局样式、分页工具栏、模态框等。

Servlet

掌握Java中的Web项目目录结构;

掌握Java Web项目的重要中间件Tomcat;

掌握Servlet中的Request和Response;

掌握Servlet的基本运行过程。

掌握Servlet的声明周期

动态网页技术

JSP在Java Web中的角色；

JSP的编码规范，以及JSPServlet；

JSP显示乱码的解决办法等。

JSP数据交互

JSP中如何编写Java代码，如何使用Java中的类；

JSP中的参数传递。

状态管理Session和Cookie

掌握Session的作用及作用域；

掌握Cookie的作用及作用域；

掌握Session及Cookie的区别，存储位置，声明周期等；

掌握Session及Cookie分别在JSP和Cookie中的使用

JSTL和EL表达式

使用EL表达式输出page、request、session、application作用域中的值

使用JSTL来做逻辑判断或循环控制

JNDI数据库连接池

JNDI的作用以及如何使用JNDI连接数据库

分页和文件上传

掌握在JSP中如何使数据达到分页的目的；

掌握在JSP表单中如何上传文件，Servlet如何处理上传请求（Commons-Fileupload、Commons-IO）。

Ajax

掌握Ajax的基本概念；

掌握jQuery中的Ajax请求；

掌握JSON

Filter、Listener；

掌握Filter和Listener

掌握Session过滤器和编码过滤器

      通过第二阶段了解前端相关的技术，如果你喜欢前端各种酷炫的效果，那么就深入学习JS、CSS。不大感兴趣的话，就浅尝辄止，并重点学习Servlet、Filter、Listener。重点学习，重点学习，重点学习。 重要的话说三遍！  

      学习完第二阶段的内容之后，就可以进行B/S版本的系统开发了。这个时候我们可以挑选个稍微复杂点儿的项目来练练手，能找到商业项目练手的那是最好不过的，没有的话，就写写学生管理系统，档案管理系统，人事管理系统之类的练练手吧。

       最后说一下本阶段的前端知识，如果将jQuery和Bootstrap学的差不多了的话，再看EasyUI这之类的前端框架也基本上都是照着API用就行了。别害怕看API，看API将是你以为的整个职场生涯必不可少的一个技能。

3、 主流技术应用
Mybatis的应用

Mybatis的Mapping与实体映射；

Mybatis中的SQL语句写法；

Mybatis的缓存。

Spring应用

Spring容器的作用；

Spring的AOP和IOC；

Spring托管Mybatis事务；

SpringMVC的应用

SpringMVC中的控制器注解、请求注解、参数注解、响应注解等；

SpringMVC中的静态资源处理；

SpringMVC的容器。

Spring+SpringMVC+Mybatis整合

SSM的整合使用；

Spring容器和SpringMVC容器

Redis+Mysql的查询优化设计

Redis的安装与连接；

Redis常用命令及各命令使用场景；

Redis存储机制；

Redis的持久化机制。

任务处理相关

HttpClient模拟请求

Quartz定时任务

常用工具

Excel&World导入导出

短信&邮件发送

Maven

Maven的作用

Maven项目的创建

Maven的生命周期

Maven中央仓库及私服

Log4J2日志

FastDFS的使用

什么是分布式文件系统；

分布式文件系统解决的问题是什么；

FastDFS的使用

通过第三阶段了解目前Java领域比较经典的三大框架，了解他们的大概功能，并加以使用。通过使用SSM开发一个简易CRM之类的项目来加强了解，理清楚框架的大致原理。搞清楚这三个框架之间的作用域以及角色。理解Redis作为内存数据库与MySQL这类关系型数据库的区别,并能使用常用的Jar包完成模拟请求,定时任务等相关系统常用功能的开发。并能够通过Maven创建SSM项目，整合Log4j或其他的日志包。了解FastDFS的作用，并理解图片上传至文件服务器和上传到tomcat之间的区别
在第三阶段的内容学习完了之后，就应该对整个系统研发有个大概的印象，实际上这个时候，独立完成一个系统之后，再回过头来仔细思考下Servlet+JDBC+JSP与SSM实现项目的相同点及区别。这样会让你更加的有收获。并能够理解非关系型数据库Redis的性能优势以及使用场景。
4、模拟实际项目开发
SpringBoot 2.0的应用

了解SpringBoot的起源及优势

了解SpringBoot项目的格式以及创建方式

yaml语法特性

application配置文件及静态资源处理

Thymeleaf模板引擎

SpringBoot核心之WebMVCConfigurer

Spring自定义错误处理

SpringBoot日志引用及切换

SpringBoot数据源和Mybatis

SpringBoot-redis应用

Struts2应用（了解即可）

通过学习Struts，了解什么是MVC；

掌握Struts是如何完成界面控制的；

掌握Struts的参数接收及传递；

掌握Struts的拦截器；

掌握Struts的OGNL和标签使用。

Hibernate应用（了解即可）

Hibernate在项目中的作用及优势；

Hibernate中的hbm与实体类之间的关系；

什么是HQL，什么是关系映射（一对一，多对一，多对多）；

了解Hibernate的事务、懒加载和缓存。

Redis哨兵模式的搭建

Linux操作系统

Linux中的常用命令；

Linux下的JDK、tomcat安装；

Linux下的项目部署方式。

Nginx的使用

Nginx的作用；

反向代理和正向代理分别是什么；

Nginx实现tomcat代理。

Mysql集群方案

Mysql集群的常用方案有哪些；

Mycat中间件的概念

Mycat的使用准则；

了解数据库的主从复制；

了解数据库的主备切换；

为什么需要主从和主备。

Solr入门

什么是全文检索；

Solr做搜索的优势是什么；

Lucene、ElasticSearch、Solr之间的关系；

Solr的安装与使用。

JVM

回顾所有所学习到的知识，联系所有框架中的自定义容器、上下文来理解变量及对象的存储

理解垃圾回收是怎么一回事

理解集中回收算法

完全理解整个堆栈模型

通过第四个阶段了解更简单易用的SpringBoot，微服务应用和存储集群相关的概念及实现方案。让自己具备一个设计高可用，可扩展的项目框架视野。这样对于后面继续专研SpringCloud / Dubbo、zookeeper这些RPC相关的框架有很大的好处。
第四阶段的内容更加偏向于互联网技术栈，通过这一节的内容能够脱离出基本的增删改查，了解出了增删查改之后，需要了解的集群、系统性能优化、外部缓存服务器使用、集群负载等概念。这些思维对于后面的提高以及学习会很有好处。
       我提到的这些东西都能搜到对应的资料，无非多踩点坑罢了。但是，看文档or项目永远进步不了。一定要上手敲，想再多也不如动手。有机会联系一名优秀学长，有个走在前面的人给你指路肯定比你自己走要快得多。
      最后，一定要动手，一定要动手，一定要动手。把代码敲烂，你才会有收获，不要被视频诱导，敲一遍之后误认为你自己会了，如果第二天你起来时已经忘了昨天学习了什么的话，那说明你还是没学会。好好加油吧。
       在所有的学习过程中，每一个节点都应该有相应的练习或者项目来进行练手，看再多的博文和视频都是不行的， 不能让自己的双手停下来，只有不停的敲打键盘，写出自己的项目，然后在实际的开发中学会如何使用debug，总结所有遇到的bug及解决思路，这样才叫做学习技术。所以，希望有兴趣的同学，能够好好努力，不要因为一点点难度就懈怠、放弃。开发这条路途，无论你工作多久，都会遇到各种奇奇怪怪的问题，以及形形色色的bug等着你去解决。
