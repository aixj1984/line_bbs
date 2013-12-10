using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Trilink.Model;
using Trilink.DAL;
using System.Data;

namespace Trilink.BLL
{
    public class CategoryAndForumManager
    {
	    private CategoryAccess  CategoryData;
        private ForumAccess ForumData;
        public CategoryAndForumManager()
		{
            CategoryData = new CategoryAccess();
            ForumData = new ForumAccess();
		}

		//安装板块ID，查询所有论坛
        public List<Category> GetCategoryAndForumByBoardID(string BoradID, string CategoryID, string UserID)
		{
            List<Category> categorys = new List<Category>();
            Category category = default(Category);
            DataSet ds_category = CategoryData.GetCategoryInfos(BoradID, CategoryID);
            foreach (DataRow dr_category in ds_category.Tables[0].Rows)
			{
                category = new Category();
                category.CategoryID = dr_category["CategoryID"].ToString();
                category.Name = dr_category["name"].ToString();
                category.BoardID = dr_category["boardID"].ToString();
                category.SortOrder = dr_category["sortOrder"].ToString();
                category.IconName = dr_category["iconName"].ToString();
                category.ForumList = new List<Forum>();
                DataSet ds_forum = ForumData.GetForumInfos(category.CategoryID,UserID);
                Forum forum = default(Forum);
                foreach (DataRow dr_forum in ds_forum.Tables[0].Rows)
                {
                    forum = new Forum();
                    forum.ForumID = dr_forum["forumID"].ToString();
                    forum.CategoryID = dr_forum["CategoryID"].ToString();
                    forum.ParentID = dr_forum["ParentID"].ToString();
                    forum.Name = dr_forum["Forum"].ToString();
                    forum.Description = dr_forum["Description"].ToString();
                    forum.SortOrder = dr_forum["SortOrder"].ToString();
                    forum.LastPosted = dr_forum["LastPosted"].ToString();
                    forum.LastTopicID = dr_forum["LastTopicID"].ToString();
                    forum.LastMessageID = dr_forum["LastMessageID"].ToString();
                    forum.LastUserID = dr_forum["LastUserID"].ToString();
                    forum.LastUserName = dr_forum["LastUserName"].ToString();
                    forum.NumTopics = dr_forum["NumTopics"].ToString();
                    forum.NumPosts = dr_forum["NumPosts"].ToString();
                    forum.RemoteURL = dr_forum["RemoteURL"].ToString();
                    forum.Flags = dr_forum["Flags"].ToString();
                    forum.ThemeURL = dr_forum["ThemeURL"].ToString();
                    forum.ForumIcon = dr_forum["ForumIcon"].ToString();
                    forum.LastTopicName = dr_forum["LastTopicName"].ToString();
                    category.ForumList.Add(forum);
                }
                categorys.Add(category);

			}
            return categorys;
		}
    }
}
