using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Trilink.Model;
using Trilink.Common;
using System.Data;

namespace Trilink.DAL
{
    public class ForumAccess
    {
		private DBHelper db;

		public ForumAccess()
		{
			db = new DBHelper();
		}

        //获取论坛板块信息
        public DataSet GetForumInfos(string CategoryID)
        {
            string SQL = @"SELECT   a.CategoryID,
                             Category = a.Name,
                             ForumID = b.ForumID,
                             Forum = b.Name,
                             b.ParentID,
                             b.ThemeURL,
                             Description,
                             b.SortOrder,
                             NumTopics = dbo.Yaf_forum_topics(b.ForumID),
                             NumPosts = dbo.Yaf_forum_posts(b.ForumID),
                             LastPosted = b.LastPosted,
                             LastMessageID = b.LastMessageID,
                             LastUserID = b.LastUserID,
                             LastUserName = Isnull(b.LastUserName,(SELECT Name
                                                               FROM   yaf_User x
                                                               WHERE  x.UserID = b.LastUserID)),
                             LastTopicID = b.LastTopicID,
                             LastTopicName = (SELECT x.Topic
                                              FROM   yaf_Topic x
                                              WHERE  x.TopicID = b.LastTopicID),
                             b.Flags,
                             Viewing = (SELECT COUNT(1)
                                        FROM   yaf_Active x
                                        WHERE  x.ForumID = b.ForumID),
                             b.RemoteURL,
                             x.ReadAccess,
				             b.ForumIcon
                    FROM     yaf_Category a
                             JOIN yaf_Forum b
                               ON b.CategoryID = a.CategoryID
                             JOIN yaf_vaccess x
                               ON x.ForumID = b.ForumID
                    WHERE    a.BoardID = 1 and a.CategoryID = b.CategoryID
                    AND ((b.Flags & 2) = 0
                          OR x.ReadAccess <> 0)
                    AND x.UserID = 1 {0}
                    ORDER BY a.SortOrder,
                             b.SortOrder";
            string condition = "";
            if (CategoryID.Length > 0)
            {
                condition = " and a.CategoryID = " + CategoryID;

            }
            return db.SelectDataEntLib_BBS(string.Format(SQL, condition));
        }

    }
}
