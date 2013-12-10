using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace Trilink.Model
{
    /// <summary>
    ///Category 的摘要说明
    /// </summary>
    public class Category
    {
        public Category()
        {

        }

        #region Attributes
        private string categoryID;
        private string boardID;
        private string name;
        private string sortOrder;
        private string iconName;
        private List<Forum> forumList;
        #endregion

        #region math
        public string CategoryID
        {
            get { return categoryID; }
            set { categoryID = value; }
        }

        public string BoardID
        {
            get { return boardID; }
            set { boardID = value; }
        }

        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        public string SortOrder
        {
            get { return sortOrder; }
            set { sortOrder = value; }
        }
        public string IconName
        {
            get { return iconName; }
            set { iconName = value; }
        }

        public List<Forum> ForumList
        {
            get { return forumList; }
            set { forumList = value; }
        }
        #endregion
    }
}