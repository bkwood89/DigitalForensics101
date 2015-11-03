using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Diagnostics; //for process
using System.IO; //for file access

namespace ForensicCollection
{
    public partial class Form3 : Form
    {
        private string toolsRoot = Directory.GetCurrentDirectory() + "/RawTools/";
        public Form3()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)//cancel button
        {
            Form1 main = new Form1();
            main.Show();
            Hide();
        }

        private void button1_Click(object sender, EventArgs e)//start listener button
        {
            update.Visible = true;
            update.Text = "Starting NetCat Listener...";
            update.Refresh();
            string command = "nc -L -v -p " + portTextBox.Text + " > allOutput.txt";
            if (portTextBox.Text != "" && portTextBox.Text != null)
            {
                if (File.Exists(toolsRoot + "/NetCat/nc.exe"))
                {
                    runCommand(command, toolsRoot + "/NetCat/");
                    update.Text = "Connection Closed. View your output in the 'Evidence' Folder.";
                    update.Refresh();
                }
                else
                {
                    update.Visible = false;
                    update.Refresh();
                    MessageBox.Show("Missing 'nc.exe'(NetCat) from 'RawTools'. Go to 'Get Tools' and download it.");
                }
            }
            else
            {
                update.Visible = false;
                update.Refresh();
                MessageBox.Show("You did not put a number in the text box.");
            }
            
        }
        private void runCommand(string commandToExecute, string dirToExecute)
        {
            update.Text += "Executing Command: nc -L -v -p " + portTextBox.Text + " > allOutput.txt";
            update.Refresh();
            try
            {
                ProcessStartInfo processStartInfo = new ProcessStartInfo("cmd", "/k " + commandToExecute);
                processStartInfo.WorkingDirectory = dirToExecute;
                processStartInfo.UseShellExecute = false;
                processStartInfo.WindowStyle = ProcessWindowStyle.Normal;//show cmd prompt
                Process process = Process.Start(processStartInfo);
                update.Text = "Listening On Port: " + portTextBox.Text + ", ready to recieve.";
                update.Refresh();
                process.WaitForExit();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
