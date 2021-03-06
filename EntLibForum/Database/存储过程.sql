set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


CREATE PROCEDURE[dbo].[yaf_topic_list_groom](
                @BoardID INT)
AS
   BEGIN
       SELECT t1.[TopicID]
      ,[Posted] --发布日期
      ,[Topic] --存储帖子主题
      ,[Views] --浏览次数
      ,[Priority]
      , T2.NAME as smallcate --小分类
	  , t2.CategoryID
	  , t1.forumId
	  , T3.NAME as largecate-- 大分类
  FROM [dbo].[yaf_Topic] t1
left join [dbo].[yaf_forum] t2 on t1.forumId = t2.forumId
left join yaf_Category t3 on t2.CategoryID = t3.CategoryID 
        WHERE  t3.BoardID = @BoardID and t1.[ApproveStatus] = 1 and t1.[Flags] = 0
order by [Posted] desc
end


------------------------------------
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


CREATE PROCEDURE[dbo].[yaf_topic_list_hot](
                @BoardID INT)
AS
    BEGIN
       SELECT t1.[TopicID]
      ,[Posted] --发布日期
      ,[Topic] --存储帖子主题
      ,[Views] --浏览次数
      ,[Priority]
      , T2.NAME as smallcate --小分类
	  , t2.CategoryID
	  , t1.forumId
	  , T3.NAME as largecate-- 大分类
	  , row_number()over(order by Views desc )as RowNum
  FROM [dbo].[yaf_Topic] t1
left join [dbo].[yaf_forum] t2 on t1.forumId = t2.forumId
left join yaf_Category t3 on t2.CategoryID = t3.CategoryID 
        WHERE  t3.BoardID = @BoardID and t1.[Flags] = 0
        --AND RowNum < 15
    END


-----------------------------
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go



CREATE PROCEDURE[dbo].[yaf_topic_list_latest](
                @BoardID INT)
AS
    BEGIN
        SELECT [TopicID]
      ,[Posted] --发布日期
      ,[Topic] --存储帖子主题
      ,[Views] --浏览次数
      ,[Priority]
      , T2.NAME as smallcate --小分类
	  , t2.CategoryID
	  , t1.forumId
	  , T3.NAME as largecate-- 大分类
  FROM [dbo].[yaf_Topic] t1
left join [dbo].[yaf_forum] t2 on t1.forumId = t2.forumId
left join yaf_Category t3 on t2.CategoryID = t3.CategoryID 
        WHERE  t3.BoardID = @BoardID and t1.[Flags] = 0
        --AND datediff(Hour, [Posted],getdate()) <= 24
order by datediff(Hour, [Posted],getdate()) asc
    END



------------------------------
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

CREATE PROCEDURE[dbo].[yaf_topic_count_byuser]
               (@BoardID INT)
AS
   BEGIN
        select t2.userid, t2.name, t2.avatar, count(*) as count from [dbo].[yaf_topic] t1
		left join [dbo].[yaf_user] t2
		on t1.userId = t2.userId
		where t1.flags != 8 and t2.BoardID = @BoardID
		group by t2.userid, t2.name, t2.avatar
		order by count(*) desc
    END

---------------
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

CREATE PROCEDURE[dbo].[yaf_get_image](
                @BoardID INT)
AS
    BEGIN
SELECT 
	   t3.topic
      ,t3.[TopicID]
      ,t2.name
      ,[Message]
  FROM [dbo].[yaf_Message] t left join [dbo].[yaf_user] t2
on t.userid = t2.userid
left join [dbo].[yaf_topic] t3 on t.[TopicID] = t3.[TopicID]
where t.message like '%useruploadfiles/' + t2.name + '/image%' and t.[Position] = 0
order by t.[Posted] desc

End

