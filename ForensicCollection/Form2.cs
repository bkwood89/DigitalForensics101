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
            warningText.Visible = false;
            filename.Visible = true;
            filename.Refresh();

            if (FileExistCheck() == true)
            {
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
                    Directory.Delete(downloadFolder, true);
                }
                else
                {
                    cleanDownloadsFolder();
                }
                phasecomplete.Visible = true;
                finishText.Visible = true;
                filename.Text = "Setup Complete!";
                filename.Refresh();
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
            if (File.Exists(Directory.GetCurrentDirectory() + "/downloadedFile/netcat-win32-1.12.zip") == false)
            {
                filename.Text = "Downloading Netcat...";
                filename.Refresh();
                netcat.Text += "Downloading.";
                netcat.Refresh();
                DownloadFile("https://eternallybored.org/misc/netcat/netcat-win32-1.12.zip", downloadFolder + "/netcat-win32-1.12.zip");
                netcat.Text += "Done.";
                netcat.Refresh();
            }
        }
        private void ExtractAllFiles()
        {
            bool rawToolsFolderExists = Directory.Exists(rawToolsDirectory);
            bool oemFolderExists = Directory.Exists(rawToolsDirectory + "/OEM");
            bool sysInternalsFolderExists = Directory.Exists(rawToolsDirectory + "/SysInternals");
            bool unixUtilsFolderExists = Directory.Exists(rawToolsDirectory + "/UnixUtils");
            bool netcatFolderExists = Directory.Exists(rawToolsDirectory + "/NetCat");

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
            if (netcatFolderExists == false)
            {
                Directory.CreateDirectory(rawToolsDirectory + "/NetCat");
            }
            filename.Text = "Extracting Files and Setting Up Enviornment...";
            filename.Refresh();
            fport.Text += "..Extracting";
            fport.Refresh();
            ZipFile.ExtractToDirectory(downloadFolder + "/fport.zip", downloadFolder + "/");

            ntlast.Text = "Fport..Extracting";
            ntlast.Refresh();
            ZipFile.ExtractToDirectory(downloadFolder + "/ntlast30.zip", downloadFolder + "/");

            oem.Text = "Microsofts OEM Support Tools..Extracting";
            oem.Refresh();
            ZipFile.ExtractToDirectory(downloadFolder + "/oem3sr2.zip", rawToolsDirectory + "/OEM/");

            sysinternals.Text = "Microsofts System Internals..Extracting";
            sysinternals.Refresh();
            ZipFile.ExtractToDirectory(downloadFolder + "/SysinternalsSuite.zip", rawToolsDirectory + "/SysInternals/");

            unixutils.Text = "Unix Utilities..Extracting";
            unixutils.Refresh();
            ZipFile.ExtractToDirectory(downloadFolder + "/UnxUtils.zip", rawToolsDirectory + "/UnixUtils/");

            netcat.Text = "NetCat...Extracting";
            netcat.Refresh();
            ZipFile.ExtractToDirectory(downloadFolder + "/netcat-win32-1.12.zip", rawToolsDirectory + "/NetCat/");

            Version win8version = new Version(6, 2, 9200, 0);

            if (Environment.OSVersion.Platform == PlatformID.Win32NT &&
                Environment.OSVersion.Version >= win8version)
            {
                MessageBox.Show("Windows 8 or newer detected. In order to have these downloaded tools to function correctly you need to set them to Windows XP Service Pack 2 Comptability mode.");
            }
        }
        private void MoveAllFiles()
        {
            filename.Text = "Moving Extracted Files...";
            filename.Refresh();
            fport.Text += "..Moving.";
            fport.Refresh();
            try
            {
                if (File.Exists(rawToolsDirectory + "/Fport.exe"))
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
            try
            {
                if (File.Exists(rawToolsDirectory + "/NTLast.exe"))
                {
                    File.Delete(rawToolsDirectory + "/NTLast.exe");
                }
                File.Move(downloadFolder + "/NTLast.exe", rawToolsDirectory + "/NTLast.exe");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            ntlast.Text += "Done.";
            ntlast.Refresh();

            oem.Text += "..Moving";
            oem.Refresh();

            oem.Text += "Done.";
            oem.Refresh();

            sysinternals.Text += "..Moving.";
            sysinternals.Refresh();

            sysinternals.Text += "Done.";
            sysinternals.Refresh();

            unixutils.Text += "..Moving.";
            unixutils.Refresh();

            unixutils.Text += "Done.";
            unixutils.Refresh();

            netcat.Text += ".Done.";
            netcat.Refresh();
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
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
        }
        private void DownloadFile(string urlAddress, string saveLocation)
        {
            using (webClient = new WebClient())
            {
                //sw.Start();//start the download speed timer
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