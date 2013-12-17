using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace Trilink.Model
{
    /// <summary>
    ///Dept 的摘要说明
    /// </summary>
    public class Forum
    {
        public Forum()
        {

        }

        #region Attributes
        private string forumID;
        private string categoryID;
        private string parentID;
        private string name;
        private string description;
        private string sortOrder;
        private string lastPosted;
        private string lastTopicID;
        private string lastMessageID;
        private string lastUserID;
        private string lastUserName;
        private string numTopics;
        private string numPosts;
        private string remoteURL;
        private string flags;
        private string themeURL;
        private string forumIcon;
        private string lastUser;
        private string lastTopicName;
        private string todayPostNum;
        #endregion

        #region math
        public string ForumID
        {
            get { return forumID; }
            set { forumID = value; }
        }
        public string CategoryID
        {
            get { return categoryID; }
            set { categoryID = value; }
        }
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        public string ParentID
        {
            get { return parentID; }
            set { parentID = value; }
        }
        public string Description
        {
            get { return description; }
            set { description = value; }
        }
        public string SortOrder
        {
            get { return sortOrder; }
            set { sortOrder = value; }
        }
        public string LastPosted
        {
            get { return lastPosted; }
            set { lastPosted = value; }
        }
        public string LastTopicID
        {
            get { return lastTopicID; }
            set { lastTopicID = value; }
        }
        public string LastMessageID
        {
            get { return lastMessageID; }
            set { lastMessageID = value; }
        }
        public string LastUserID
        {
            get { return lastUserID; }
            set { lastUserID = value; }
        }
        public string LastUserName
        {
            get { return lastUserName; }
            set { lastUserName = value; }
        }
        public string NumTopics
        {
            get { return numTopics; }
            set { numTopics = value; }
        }
        public string NumPosts
        {
            get { return numPosts; }
            set { numPosts = value; }
        }
        public string RemoteURL
        {
            get { return remoteURL; }
            set { remoteURL = value; }
        }
        public string Flags
        {
            get { return flags; }
            set { flags = value; }
        }
        public string ThemeURL
        {
            get { return themeURL; }
            set { themeURL = value; }
        }
        public string ForumIcon
        {
            get { return forumIcon; }
            set { forumIcon = value; }
        }
        public string LastUser
        {
            get { return lastUser; }
            set { lastUser = value; }
        }
        public string LastTopicName
        {
            get { return lastTopicName; }
            set { lastTopicName = value; }
        }


        public string TodayPostNum
        {
            get { return todayPostNum; }
            set { todayPostNum = value; }
        }
        
        
        #endregion

       
    }
}