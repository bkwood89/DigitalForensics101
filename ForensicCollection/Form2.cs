using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net; // for downloading web files
using System.IO; //for file access
using System.IO.Compression; //for extracting zip files
using System.Diagnostics; //for process

namespace ForensicCollection
{
    public partial class Form2 : Form
    {
        WebClient webClient;               // Our WebClient that will be doing the downloading for us
        Stopwatch sw = new Stopwatch();    // The stopwatch which we will be using to calculate the download speed
        string downloadFolder = Directory.GetCurrentDirectory() + "/downloadedFiles";
        string rawToolsDirectory = Directory.GetCurrentDirectory() + "/RawTools";
        public Form2()
        {
            InitializeComponent();
        }

        private void start_Click(object sender, EventArgs e)
        {
            //toolsListText.Visible = false;
            //fport.Visible = false;
            //ntlast.Visible = false;
            //sysinternals.Visible = false;
            //oem.Visible = false;
            //unixutils.Visible = false;
            warningText.Visible = false;

            //labelSpeed.Visible = true;
            //labelPerc.Visible = true;
            //labelDownloaded.Visible = true;
            //progressBar.Visible = true;
            filename.Visible = true;

            //labelSpeed.Refresh();
            //labelPerc.Refresh();
            //labelDownloaded.Refresh();
            //progressBar.Refresh();
            filename.Refresh();

            if (FileExistCheck() == true)
            {
                //labelSpeed.Visible = false;
                //labelPerc.Visible = false;
                //labelDownloaded.Visible = false;
                //progressBar.Visible = false;
                filename.Visible = false;
            }
            else
            {
                phase1.Visible = true;
                phase1.Refresh();
                DownloadAllFiles();

                phase2.Visible = true;
                phase2.Refresh();
                ExtractAllFiles();

                phase3.Visible = true;
                phase3.Refresh();
                MoveAllFiles();
                
                if (keepFiles.Checked == false)
                {
                    Directory.Delete(downloadFolder,true);
                }
                else
                {
                    cleanDownloadsFolder();
                }
                phasecomplete.Visible = true;
                finishText.Visible = true;
            }
        }
        private bool FileExistCheck()
        {
            if (Directory.Exists(rawToolsDirectory + "/OEM"))
            {
                MessageBox.Show("Please clear all files From your 'RawTools' directory to continue.");
                return true;
            }
            if (Directory.Exists(rawToolsDirectory + "/SysInternals"))
            {
                MessageBox.Show("Please clear all files From your 'RawTools' directory to continue.");
                return true;
            }
            if (Directory.Exists(rawToolsDirectory + "/UnixUtils"))
            {
                MessageBox.Show("Please clear all files From your 'RawTools' directory to continue.");
                return true;
            }
            if (File.Exists(rawToolsDirectory + "/Fport.exe"))
            {
                MessageBox.Show("Please clear all files From your 'RawTools' directory to continue.");
                return true;
            }
            if (File.Exists(rawToolsDirectory + "/NTLast.exe"))
            {
                MessageBox.Show("Please clear all files From your 'RawTools' directory to continue.");
                return true;
            }
            return false;
        }
        private void DownloadAllFiles()
        {
            bool downloadFolderExists = Directory.Exists(downloadFolder);
            if (downloadFolderExists == false)
            {
                Directory.CreateDirectory(downloadFolder);
            }
            if (File.Exists(downloadFolder + "/fport.zip") == false)
            {
                filename.Text = "Downloading Fport v2.0 ...";
                filename.Refresh();
                fport.Text += "...Downloading.";
                fport.Refresh();
                DownloadFile("http://b2b-download.mcafee.com/products/tools/foundstone/fport.zip", downloadFolder + "/fport.zip");
                fport.Text += "Done.";
                fport.Refresh();
            }
            if (File.Exists(Directory.GetCurrentDirectory() + "/downloadedFile/ntlast30.zip") == false)
            {
                filename.Text = "Downloading NTLast v3.0...";
                filename.Refresh();
                ntlast.Text += "...Downloading.";
                ntlast.Refresh();
                DownloadFile("http://b2b-download.mcafee.com/products/tools/foundstone/ntlast30.zip", downloadFolder + "/ntlast30.zip");
                ntlast.Text += "Done.";
                ntlast.Refresh();
            }
            if (File.Exists(Directory.GetCurrentDirectory() + "/downloadedFile/oem3sr2.zip") == false)
            {
                filename.Text = "Downloading Microsoft's OEM Support Tools...";
                filename.Refresh();
                oem.Text += "...Downloading.";
                oem.Refresh();
                DownloadFile("http://download.microsoft.com/download/win2000srv/utility/3.0/nt45/en-us/oem3sr2.zip", downloadFolder + "/oem3sr2.zip");
                oem.Text += "Done.";
                oem.Refresh();
            }
            if (File.Exists(Directory.GetCurrentDirectory() + "/downloadedFile/UnxUtils.zip") == false)
            {
                filename.Text = "Downloading Unix Utilities...";
                filename.Refresh();
                unixutils.Text += "...Downloading.";
                unixutils.Refresh();
                DownloadFile("http://superb-dca2.dl.sourceforge.net/project/unxutils/unxutils/current/UnxUtils.zip", downloadFolder + "/UnxUtils.zip");
                unixutils.Text += "Done.";
                unixutils.Refresh();
            }
            if (File.Exists(Directory.GetCurrentDirectory() + "/downloadedFile/SysinternalsSuite.zip") == false)
            {
                filename.Text = "Downloading Microsoft's System Internals Suite...";
                filename.Refresh();
                sysinternals.Text += "Downloading.";
                sysinternals.Refresh();
                DownloadFile("https://download.sysinternals.com/files/SysinternalsSuite.zip", downloadFolder + "/SysinternalsSuite.zip");
                sysinternals.Text += "Done.";
                sysinternals.Refresh();
            }
            sw.Stop();
        }
        private void ExtractAllFiles()
        {
            bool rawToolsFolderExists = Directory.Exists(rawToolsDirectory);
            bool oemFolderExists = Directory.Exists(rawToolsDirectory + "/OEM");
            bool sysInternalsFolderExists = Directory.Exists(rawToolsDirectory + "/SysInternals");
            bool unixUtilsFolderExists = Directory.Exists(rawToolsDirectory + "/UnixUtils");

            if (rawToolsFolderExists == false)
            {
                Directory.CreateDirectory(rawToolsDirectory);
            }
            if (oemFolderExists == false)
            {
                Directory.CreateDirectory(rawToolsDirectory + "/OEM");
            }
            if (sysInternalsFolderExists == false)
            {
                Directory.CreateDirectory(rawToolsDirectory + "/SysInternals");
            }
            if (unixUtilsFolderExists == false)
            {
                Directory.CreateDirectory(rawToolsDirectory + "/UnixUtils");
            }
            filename.Text = "Extracting Files and Setting Up Enviornment...";
            fport.Text += "..Extracting";
            fport.Refresh();
            ZipFile.ExtractToDirectory(downloadFolder + "/fport.zip", downloadFolder+"/");

            ntlast.Text = "Fport..Extracting";
            ntlast.Refresh();
            ZipFile.ExtractToDirectory(downloadFolder + "/ntlast30.zip", downloadFolder+"/");

            oem.Text = "Microsofts OEM Support Tools..Extracting";
            oem.Refresh();
            ZipFile.ExtractToDirectory(downloadFolder + "/oem3sr2.zip", rawToolsDirectory + "/OEM/");

            sysinternals.Text = "Microsofts System Internals..Extracting";
            sysinternals.Refresh();
            ZipFile.ExtractToDirectory(downloadFolder + "/SysinternalsSuite.zip", rawToolsDirectory + "/SysInternals/");

            unixutils.Text = "Unix Utilities..Extracting";
            unixutils.Refresh();
            ZipFile.ExtractToDirectory(downloadFolder + "/UnxUtils.zip", rawToolsDirectory + "/UnixUtils/");
        }
        private void MoveAllFiles()
        {
            filename.Text = "Moving Extracted Files...";
            filename.Refresh();
            fport.Text += "..Moving.";
            fport.Refresh();
            try {
                if(File.Exists(rawToolsDirectory + "/Fport.exe"))
                {
                    File.Delete(rawToolsDirectory + "/Fport.exe");
                }
                File.Move(downloadFolder + "/Fport-2.0/Fport.exe", rawToolsDirectory + "/Fport.exe");
                Directory.Delete(downloadFolder + "/Fport-2.0/", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            File.Delete(downloadFolder + "/fport.zip");
            fport.Text += "Done.";
            fport.Refresh();

            ntlast.Text += "..Moving.";
            try {
                if (File.Exists(rawToolsDirectory + "/NTLast.exe"))
                {
                    File.Delete(rawToolsDirectory + "/NTLast.exe");
                }
                //File.Move(downloadFolder + "/Fport-2.0/Fport.exe", rawToolsDirectory + "/Fport.exe");
                File.Move(downloadFolder + "/NTLast.exe", rawToolsDirectory + "/NTLast.exe");
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            ntlast.Text += "Done.";
            ntlast.Refresh();

            oem.Text += "..Moving";
            oem.Refresh();
            //try {
            //    List<String> oemFiles = Directory.GetFiles(downloadFolder + "/OEM/", "*.*", SearchOption.AllDirectories).ToList();
            //    foreach (string file in oemFiles)
            //    {
            //        FileInfo mFile = new FileInfo(file);
            //        mFile.MoveTo(rawToolsDirectory + "/OEM/" + mFile.Name);
            //    }
            //}
            //catch(Exception ex)
            //{
            //    MessageBox.Show(ex.Message);
            //}
            oem.Text += "Done.";
            oem.Refresh();

            sysinternals.Text += "..Moving.";
            sysinternals.Refresh();
            //try {
            //    List<String> sysInternalFiles = Directory.GetFiles(downloadFolder + "/SysInternals/", "*.*", SearchOption.AllDirectories).ToList();
            //    foreach (string file in sysInternalFiles)
            //    {
            //        FileInfo mFile = new FileInfo(file);
            //        mFile.MoveTo(rawToolsDirectory + "/SysInternals/" + mFile.Name);
            //    }
            //}
            //catch(Exception ex)
            //{
            //    MessageBox.Show(ex.Message);
            //}
            sysinternals.Text += "Done.";
            sysinternals.Refresh();

            unixutils.Text += "..Moving.";
            unixutils.Refresh();
            //try {
            //    List<String> unixUtilesFiles = Directory.GetFiles(downloadFolder + "/UnixUtils/", "*.*", SearchOption.AllDirectories).ToList();
            //    foreach (string file in unixUtilesFiles)
            //    {
            //        FileInfo mFile = new FileInfo(file);
            //        mFile.MoveTo(rawToolsDirectory + "/UnixUtils/" + mFile.Name);
            //    }
            //}
            //catch(Exception ex)
            //{
            //    MessageBox.Show(ex.Message);
            //}
            unixutils.Text += "Done.";
            unixutils.Refresh();
        }
        private void cleanDownloadsFolder()
        {
            DirectoryInfo di = new DirectoryInfo(downloadFolder);
            FileInfo[] files = di.GetFiles("*.txt")
                                 .Where(p => p.Extension == ".txt").ToArray();
            foreach (FileInfo file in files)
                try
                {
                    file.Attributes = FileAttributes.Normal;
                    File.Delete(file.FullName);
                }
                catch (Exception ex){
                    MessageBox.Show(ex.Message);
                }
        }
        private void DownloadFile(string urlAddress, string saveLocation)
        {
            using (webClient = new WebClient())
            {
                sw.Start();//start the download speed timer
                //webClient.DownloadFileCompleted += new AsyncCompletedEventHandler(Completed);
                //webClient.DownloadProgressChanged += new DownloadProgressChangedEventHandler(ProgressChanged);
                // The variable that will be holding the url address (making sure it starts with http://)
                Uri URL = new Uri(urlAddress);//urlAddress.StartsWith("http://", StringComparison.OrdinalIgnoreCase) ? new Uri(urlAddress) : new Uri("http://" + urlAddress);
                try
                {
                    // Start downloading the file
                    webClient.DownloadFile(URL, saveLocation);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        // The event that will fire whenever the progress of the WebClient is changed
        //private void ProgressChanged(object sender, DownloadProgressChangedEventArgs e)
        //{
        //    // Calculate download speed and output it to labelSpeed.
        //    labelSpeed.Text = string.Format("{0} kb/s", (e.BytesReceived / 1024d / sw.Elapsed.TotalSeconds).ToString("0.00"));
        //    // Update the progressbar percentage only when the value is not the same.
        //    progressBar.Value = e.ProgressPercentage;
        //    // Show the percentage on our label.
        //    labelPerc.Text = e.ProgressPercentage.ToString() + "%";
        //    // Update the label with how much data have been downloaded so far and the total size of the file we are currently downloading
        //    labelDownloaded.Text = string.Format("{0} MB's / {1} MB's",
        //        (e.BytesReceived / 1024d / 1024d).ToString("0.00"),
        //        (e.TotalBytesToReceive / 1024d / 1024d).ToString("0.00"));
        //}

        // The event that will trigger when the WebClient is completed
        private void Completed(object sender, AsyncCompletedEventArgs e)
        {
            // Reset the stopwatch.
            sw.Reset();

            if (e.Cancelled == true)
            {
                MessageBox.Show("Download has been canceled.");
            }
            else
            {
                MessageBox.Show("Download completed!");
            }
        }

        private void Cancel_Click(object sender, EventArgs e)
        {
            Hide();
        }
    }
}
