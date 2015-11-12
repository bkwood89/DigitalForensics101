using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System.Windows.Forms;
using System.Reflection; //for assembly
using System.Diagnostics; //for process
using System.IO; //for file access
using System.Security.Cryptography; //for sha1sum of files
using System.Net; // for downloading web files

namespace ForensicCollection
{
    public partial class Form1 : Form
    {
        private string errorOnTools;
        private string toolsRoot = Directory.GetCurrentDirectory() + "/RawTools/";
        private string netcatRoot = Directory.GetCurrentDirectory() + "/RawTools/NetCat/";
        private string saveOption;
        private string allCommands = "";
        private string netcatCmd = "";
        WebClient webClient;               // Our WebClient that will be doing the downloading for us
        Stopwatch sw = new Stopwatch();    // The stopwatch which we will be using to calculate the download speed
        public object FPort { get; private set; }

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            allCommands = "";
            netcatCmd = "";
            if (saveOption == "Netcat Session")
            {
                if (portTextBox.Text == null || portTextBox.Text == "")
                {
                    MessageBox.Show("Missing Port Number.");
                    return;
                }
                if (ipTextBox.Text == null || ipTextBox.Text == "")
                {
                    MessageBox.Show("Missing IP address to send to.");
                    return;
                }
                netcatCmd = "nc " + ipTextBox.Text + " " + portTextBox.Text;
                allCommands = "(";

            }
            string netcat = "" + portTextBox.Text;
            output.Text = "";
            warningText.Text = "";
            if (String.IsNullOrEmpty(saveOption) == true)
            {
                warningText.Text = "Warning: You haven't Selected A Save Option Yet";
                return;
            }
            if (fport.Checked == true)
            {
                if (saveOption == "Netcat Session")
                {
                    string fportEXE = Directory.GetCurrentDirectory() + "/RawTools/fport";
                    allCommands += "(echo --BEGIN && " + fportEXE + " && echo --END)";
                    allCommands += "&&";
                }
                else
                {
                    saveOutput(runCommand("Fport", toolsRoot), "fport.txt");
                }
            }
            if (ntlast.Checked == true)
            {
                if (saveOption == "Netcat Session")
                {
                    string ntlastEXE = Directory.GetCurrentDirectory() + "/RawTools/ntlast";
                    allCommands += "(echo --BEGIN && " + ntlastEXE + " && echo --END)";
                    allCommands += "&&";
                }
                else
                {
                    saveOutput(runCommand("NTLast", toolsRoot), "NTLast.txt");
                }
            }
            if (userdump.Checked == true)
            {
                if (saveOption == "Netcat Session")
                {
                    
                }
                else
                {
                    saveOutput(runCommand("userdump -p", toolsRoot + "/OEM/userdump/"), "userdump.txt");
                }
            }
            if (netstat_an.Checked == true)
            {
                saveOutput(runCommand("netstat -an", toolsRoot), "netstat-an.txt");
            }
            if (netstat_rn.Checked == true)
            {
                saveOutput(runCommand("netstat -rn", toolsRoot), "netstat-rn.txt");
            }
            if (psfile.Checked == true)
            {
                saveOutput(runCommand("psfile", toolsRoot + "/SysInternals/"), "psfile.txt");
            }
            if (pslist.Checked == true)
            {
                saveOutput(runCommand("pslist", toolsRoot + "/SysInternals/"), "pslist.txt");
            }
            if (ipconfig_all.Checked == true)
            {
                saveOutput(runCommand("ipconfig -all", toolsRoot), "ipconfig-all.txt");
            }
            if (date.Checked == true)
            {
                saveOutput(runCommand("date", toolsRoot), "date.txt");
            }
            if (time.Checked == true)
            {
                saveOutput(runCommand("time", toolsRoot), "time.txt");
            }
            if (psinfo_h_s_d.Checked == true)
            {
                saveOutput(runCommand("psinfo -h -s -d", toolsRoot + "/SysInternals/"), "psinfo-h-s-d.txt");
            }
            if (psloggedon.Checked == true)
            {
                saveOutput(runCommand("psloggedon", toolsRoot + "/SysInternals/"), "psloggedon.txt");
            }
            if (psservice.Checked == true)
            {
                saveOutput(runCommand("psservice", toolsRoot + "/SysInternals/"), "psservice.txt");
            }
            if (schtasks.Checked == true)
            {
                saveOutput(runCommand("schtasks", toolsRoot + "/SysInternals/"), "schtasks.txt");
            }
            if (find.Checked == true)
            {
                saveOutput(runCommand("find c:/ -printf '%m;%Ax;%AT;%Tx;%TT;%Cx;%CT;%U;%G;%s;%p\n'", toolsRoot + "/UnixUtils/usr/local/wbin/"), "find.txt");
            }
            if (psloglist.Checked == true)
            {
                saveOutput(runCommand("psloglist -s -x security", toolsRoot + "/SysInternals/"), "psloglist.txt");
            }
            if (sha1sum.Checked == true)
            {
                sha1sumAllFiles(Directory.GetCurrentDirectory() + "/Evidence/");
            }
            if (saveOption == "Netcat Session")
            {
                allCommands += "echo --END )";
                runCommand(allCommands + " |" + netcatCmd + " | TASKKILL /F /IM cmd.exe", netcatRoot);
            }
            output.Text += "Finished Running All Commands.";
            if (string.IsNullOrEmpty(errorOnTools) == false)
            {
                MessageBox.Show("There were errors while trying to run the following commands:\n" + errorOnTools + "\nto prevent these simply setup your forensic enviornment by clicking the 'Get Tools' button and then pressing 'Start'.");
            }
        }

        private void testRun(string commandToExecute, string dirToExecute)
        {

            // Connect to the Reverse Shell persistent listener on the Forensic computer
            //runCommand("nc " + ipTextBox.Text + " " + portTextBox.Text, toolsRoot + "/NetCat/");
            string strCmdText;


            //Debug.WriteLine(portNum);
            //Debug.WriteLine(reverseShellNewListenerPortNum);
            //                strCmdText = "nc " + ipTextBox.Text + " " + portTextBox.Text;

            strCmdText = "/C cd " + Directory.GetCurrentDirectory() + "/RawTools/" + " & fport | nc " + ipTextBox.Text + " " + portTextBox.Text;
            //Debug.WriteLine(strCmdText);
            Process reverseShell = new Process();
            ProcessStartInfo RSStartInfo = new ProcessStartInfo();
            //RSStartInfo.WindowStyle = ProcessWindowStyle.Maximized;  //Testing purposes only
            RSStartInfo.FileName = "cmd.exe";
            RSStartInfo.Arguments = strCmdText;
            RSStartInfo.LoadUserProfile = true;

            RSStartInfo.UseShellExecute = false;
            RSStartInfo.RedirectStandardInput = true;
            RSStartInfo.RedirectStandardOutput = true;
            RSStartInfo.RedirectStandardError = true;

            reverseShell.StartInfo = RSStartInfo;
            reverseShell.Start();
            reverseShell.Kill();

            //Thread.Sleep(5000);
            // This is the type of command you will send to the reverse shell to create another listner on the forensic machine.
            //reverseShell.StandardInput.WriteLine("cmd.exe /k nc -l -v -p " + reverseShellNewListenerPortNum + " > FINDME.txt");



        }

        private string runCommand(string commandToExecute, string dirToExecute)
        {
            output.Text += "Running " + commandToExecute + "...";
            string commandOutput = string.Empty;//clear any possible residual strings
            string error = string.Empty;//clear any possible residual strings

            ProcessStartInfo processStartInfo = new ProcessStartInfo("cmd", "/c " + commandToExecute);
            //ProcessStartInfo processStartInfo = new ProcessStartInfo("@"+commandToExecute);
            processStartInfo.WorkingDirectory = dirToExecute;
            processStartInfo.RedirectStandardOutput = true;//allows use to redirect ouput (normal)
            processStartInfo.RedirectStandardError = true;//allows use to redirect ouput (errors)
            processStartInfo.CreateNoWindow = true;
            processStartInfo.UseShellExecute = false;
            processStartInfo.WindowStyle = ProcessWindowStyle.Hidden;//don't show cmd prompt
            processStartInfo.UseShellExecute = false;//this is to allow the redirecting of output to our string
            Process process = new Process();
            try
            {
                process = Process.Start(processStartInfo);
            }
            catch (Exception e)
            {
                errorOnTools += commandToExecute + "\n";
            }
            //using (StreamReader streamReader = process.StandardOutput)
            //{
            //    commandOutput = streamReader.ReadToEnd();//capture normal output
            //}

            //using (StreamReader streamReader = process.StandardError)
            //{
            //    error = streamReader.ReadToEnd();//capture any errors
            //    output.Text += "\n" + error + "... ";
            //}
            //Consolidate Errors and output into one long line
            string finalOutput = commandOutput + " " + error;
            output.Text += "Done.\n";

            return finalOutput;
        }
        private void saveOutput(string textForFile, string fileName)
        {
            output.Text += "Saving " + fileName + "...";
            //make folder at exe location and save txt
            string path = Directory.GetCurrentDirectory() + "/Evidence/" + fileName;
            //If folder doesn't exists create it otherwise just access it and save to it
            bool folderExists = Directory.Exists(Directory.GetCurrentDirectory() + "/Evidence/");
            if (!folderExists)
            {
                output.Text += "Creating Folder...";
                Directory.CreateDirectory(Directory.GetCurrentDirectory() + "/Evidence/");
            }
            //Create the txt file at path
            if (!File.Exists(path))
            {
                var outputFile = File.Create(path);
                outputFile.Close();
            }
            //write the output to the text file
            File.WriteAllText(path, textForFile);
            output.Text += "Done.\n";
        }
        private void sha1sumAllFiles(string directory)
        {
            output.Text += "Taking sha1sum's of all files...\n";
            // Create a DirectoryInfo object representing the specified directory.
            DirectoryInfo dir = new DirectoryInfo(directory);
            // Get the FileInfo objects for every file in the directory.
            FileInfo[] files = dir.GetFiles();
            // Initialize a RIPE160 hash object.
            RIPEMD160 myRIPEMD160 = RIPEMD160Managed.Create();
            byte[] hashValue;
            // Compute and print the hash values for each file in directory.
            foreach (FileInfo fInfo in files)
            {
                output.Text += "Taking sha1sum for " + fInfo.Name + "...";
                // Create a fileStream for the file.
                FileStream fileStream = fInfo.Open(FileMode.Open);
                // Be sure it's positioned to the beginning of the stream.
                fileStream.Position = 0;
                // Compute the hash of the fileStream.
                hashValue = myRIPEMD160.ComputeHash(fileStream);
                //conver the byte array to a HEX string
                string convertedHash = HexStringFromBytes(hashValue);
                // Write the Hex value to a file called <FILENAME>.sha
                if (File.Exists(Directory.GetCurrentDirectory() + "/Evidence/" + Path.GetFileNameWithoutExtension(fInfo.Name) + ".sha"))
                {
                    warningText.Text = "Warning: Ended with errors. Check the output window for information.";
                    string errorText = "\nERROR:File already exsists. Remove it and try again.\n";
                    output.AppendText(errorText);
                }
                else
                {
                    File.WriteAllText(directory + "/" + Path.GetFileNameWithoutExtension(fInfo.Name) + ".sha", convertedHash + " *" + Path.GetFileName(fInfo.Name));
                }
                // Close the file.
                fileStream.Close();
                output.Text += "Done.\n";
            }
            output.Text += "Finished taking sha1sums of all files.\n";
        }

        public static string HexStringFromBytes(byte[] bytes)
        {
            var sb = new StringBuilder();
            foreach (byte b in bytes)
            {
                var hex = b.ToString("x2");
                sb.Append(hex);
            }
            return sb.ToString();
        }
        private void saveBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Reset Everything on every call
            portText.Visible = false;
            portTextBox.Visible = false;
            warningText.Text = "";
            //decide what has been selected
            saveOption = saveBox.SelectedItem.ToString();
            //logic for selected options
            if (saveOption == "Netcat Session")
            {
                portText.Text = "Send Through Port:";
                portText.Visible = true;
                portTextBox.Visible = true;
                sendIPLabel.Visible = true;
                ipTextBox.Visible = true;
            }
            else if (saveOption == "Local")
            {
                portText.Text = "This will save everything in the 'Evidence' Folder. ";
                portText.Visible = true;
                portTextBox.Visible = false;
                sendIPLabel.Visible = false;
                ipTextBox.Visible = false;
            }
        }

        private void toolsButton_Click(object sender, EventArgs e)
        {
            Hide();
            Form2 form2 = new Form2();
            form2.ShowDialog();
            form2 = null;
            Show();
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            Form3 listener = new Form3();
            listener.Show();
            Hide();
        }
    }
}
