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
using System.Security.Cryptography; //for sha1sum of files

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
            string command = "nc -L -v -p " + portTextBox.Text + " >> allOutput.txt";
            if (portTextBox.Text != "" && portTextBox.Text != null)
            {
                if (File.Exists(toolsRoot + "/NetCat/nc.exe"))
                {
                    runCommand(command, toolsRoot + "/NetCat/");
                    update.Text = "Connection Closed. Parsing Output File.";
                    update.Refresh();
                    parseFile();
                    if (checkBox1.Checked == true)
                    {
                        update.Text = "Capture SHA1 for all files.";
                        update.Refresh();
                        sha1sumAllFiles(Directory.GetCurrentDirectory() + "/Evidence/");
                    }
                    update.Text = "Complete! View output of your commands in the 'Evidence' folder.";
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
        private void parseFile()
        {
            //make folder at exe location and save txt
            //If folder doesn't exists create it otherwise just access it and save to it
            bool folderExists = Directory.Exists(Directory.GetCurrentDirectory() + "/Evidence/");
            if (!folderExists)
            {
                Directory.CreateDirectory(Directory.GetCurrentDirectory() + "/Evidence/");
            }

            int counter = 0;
            bool fileContents = true;
            StreamReader reader = File.OpenText(toolsRoot + "/NetCat/allOutput.txt");
            string line;
            while ((line = reader.ReadLine()) != null)
            {
                Debug.WriteLine(line);

                if (line.StartsWith("--END"))
                {
                    fileContents = false;
                    counter = counter + 1;
                }

                else if (line.StartsWith("--BEGIN") || fileContents)
                {
                    fileContents = true;
                    if (counter == 0)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/fport.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 1)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/ntlast.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 2)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/userdump.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 3)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/netstat_an.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 4)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/netstat_rn.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 5)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/psfile.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 6)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/pslist.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 7)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/ipconfig_all.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 8)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/date.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 9)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/time.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 10)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/psinfo_h_s_d.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 11)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/psloggedon.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 12)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/psservice.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 13)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/schtasks.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 14)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/find.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }
                    else if (counter == 15)
                    {
                        StreamWriter file = new System.IO.StreamWriter(Directory.GetCurrentDirectory() + "/Evidence/psloglist.txt", true);
                        file.WriteLine(line);
                        file.Close();
                    }


                }

            }
        }

        private void sha1sumAllFiles(string directory)
        {
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
                }
                else
                {
                    File.WriteAllText(directory + "/" + Path.GetFileNameWithoutExtension(fInfo.Name) + ".sha", convertedHash + " *" + Path.GetFileName(fInfo.Name));
                }
                // Close the file.
                fileStream.Close();
            }
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
    }
}
