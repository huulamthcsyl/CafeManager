﻿using QuanLiQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiQuanCafe.DAO
{
    public class CategoryDAO
    {
        private static CategoryDAO instance;

        public static CategoryDAO Instance
        {
            get { if (instance == null) instance = new CategoryDAO(); return CategoryDAO.instance; }
            private set { CategoryDAO.instance = value; }
        }

        public CategoryDAO() { }

        public List<Category> GetListCategory()
        {
            List<Category> list = new List<Category>();

            string query = "SELECT * FROM dbo.FoodCategory";

            DataTable data = DataProvider.Instance.ExcuteQuery(query);

            foreach(DataRow row in data.Rows)
            {
                Category category = new Category(row);

                list.Add(category);
            }

            return list;
        }

        public Category GetCatergoryByID(int id)
        {
            Category category = null;

            string query = "SELECT * FROM dbo.FoodCategory WHERE id = " + id;

            DataTable data = DataProvider.Instance.ExcuteQuery(query);

            foreach (DataRow row in data.Rows)
            {
                category = new Category(row);

                return category;
            }

            return category;
        }
    }
}
