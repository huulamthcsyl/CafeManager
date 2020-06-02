using QuanLiQuanCafe.DAO;
using QuanLiQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLiQuanCafe
{
    public partial class fAccountProfile : Form
    {
        private Account loginAccount;

        public Account LoginAccount
        {
            get { return loginAccount; }
            set { loginAccount = value; ChangeAccount(LoginAccount); }
        }

        public fAccountProfile(Account acc)
        {
            InitializeComponent();

            this.LoginAccount = acc;
        }

        void ChangeAccount(Account acc)
        {
            txbUserName.Text = LoginAccount.Username;
            txbDisplayName.Text = LoginAccount.DisplayName;
        }

        void UpdateAccount()
        {
            string displayName = txbDisplayName.Text;
            string password = txbOldPassword.Text;
            string newPassword = txbNewPassword.Text;
            string username = txbUserName.Text;
            string rePass = txbRePassword.Text;

            if (!newPassword.Equals(rePass))
            {
                MessageBox.Show("Vui lòng nhập mật khẩu mới!");
            }
            else
            {
                if(AccountDAO.Instance.UpdateAccount(username, displayName, password, newPassword))
                {
                    MessageBox.Show("Thay đổi thành công!");
                    if(updateAccountInfo != null)
                    {
                        updateAccountInfo(this, new AccountEvent(AccountDAO.Instance.GetAccountByUsername(username)));
                    }
                }
                else
                {
                    MessageBox.Show("Vui lòng kiểm tra lại thông tin!");
                }
            }
        }

        private event EventHandler<AccountEvent> updateAccountInfo;

        public event EventHandler<AccountEvent> UpdateAccountInfo
        {
            add { updateAccountInfo += value; }
            remove { updateAccountInfo -= value; }
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            UpdateAccount();
        }
    }

    public class AccountEvent : EventArgs
    {
        private Account acc;

        public Account Acc { get => acc; set => acc = value; }

        public AccountEvent(Account acc)
        {
            this.Acc = acc;
        }

    }
}
