﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLiQuanCafe.DTO
{
    public class Food
    {
        private int iD;
        private string name;
        private int categoryID;
        private double price;

        public int ID { get => iD; set => iD = value; }
        public string Name { get => name; set => name = value; }
        public int CategoryID { get => categoryID; set => categoryID = value; }
        public double Price { get => price; set => price = value; }

        public Food(int id, string name, int categoryID, double price)
        {
            this.ID = id;
            this.Name = name;
            this.CategoryID = categoryID;
            this.Price = price;
        }

        public Food(DataRow row)
        {
            this.ID = (int)row["id"];
            this.Name = (string)row["name"];
            this.CategoryID = (int)row["idCategory"];
            this.price = (double)row["price"];
        }
    }
}