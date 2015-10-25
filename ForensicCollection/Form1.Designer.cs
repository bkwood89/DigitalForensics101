namespace ForensicCollection
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.titleText = new System.Windows.Forms.Label();
            this.captureButton = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.output = new System.Windows.Forms.RichTextBox();
            this.fport = new System.Windows.Forms.CheckBox();
            this.label2 = new System.Windows.Forms.Label();
            this.saveBox = new System.Windows.Forms.ComboBox();
            this.warningText = new System.Windows.Forms.Label();
            this.portText = new System.Windows.Forms.Label();
            this.portTextBox = new System.Windows.Forms.TextBox();
            this.ntlast = new System.Windows.Forms.CheckBox();
            this.userdump = new System.Windows.Forms.CheckBox();
            this.netstat_an = new System.Windows.Forms.CheckBox();
            this.netstat_rn = new System.Windows.Forms.CheckBox();
            this.psfile = new System.Windows.Forms.CheckBox();
            this.pslist = new System.Windows.Forms.CheckBox();
            this.ipconfig_all = new System.Windows.Forms.CheckBox();
            this.date = new System.Windows.Forms.CheckBox();
            this.time = new System.Windows.Forms.CheckBox();
            this.psinfo_h_s_d = new System.Windows.Forms.CheckBox();
            this.psloggedon = new System.Windows.Forms.CheckBox();
            this.psservice = new System.Windows.Forms.CheckBox();
            this.schtasks = new System.Windows.Forms.CheckBox();
            this.find = new System.Windows.Forms.CheckBox();
            this.psloglist = new System.Windows.Forms.CheckBox();
            this.sha1sum = new System.Windows.Forms.CheckBox();
            this.toolsButton = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // titleText
            // 
            this.titleText.AutoSize = true;
            this.titleText.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.titleText.Location = new System.Drawing.Point(105, 9);
            this.titleText.Name = "titleText";
            this.titleText.Size = new System.Drawing.Size(313, 24);
            this.titleText.TabIndex = 0;
            this.titleText.Text = "Forensic Evidence Capture Tool";
            // 
            // captureButton
            // 
            this.captureButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.captureButton.Location = new System.Drawing.Point(370, 298);
            this.captureButton.Name = "captureButton";
            this.captureButton.Size = new System.Drawing.Size(168, 40);
            this.captureButton.TabIndex = 1;
            this.captureButton.Text = "Capture";
            this.captureButton.UseVisualStyleBackColor = true;
            this.captureButton.Click += new System.EventHandler(this.button1_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Underline, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(12, 46);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(150, 16);
            this.label1.TabIndex = 2;
            this.label1.Text = "Select What To Capture";
            // 
            // output
            // 
            this.output.Location = new System.Drawing.Point(324, 65);
            this.output.Name = "output";
            this.output.Size = new System.Drawing.Size(214, 200);
            this.output.TabIndex = 3;
            this.output.Text = "Progress of commands will be shown here";
            // 
            // fport
            // 
            this.fport.AutoSize = true;
            this.fport.Checked = true;
            this.fport.CheckState = System.Windows.Forms.CheckState.Checked;
            this.fport.Location = new System.Drawing.Point(12, 65);
            this.fport.Name = "fport";
            this.fport.Size = new System.Drawing.Size(50, 17);
            this.fport.TabIndex = 4;
            this.fport.Text = "Fport";
            this.fport.UseVisualStyleBackColor = true;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Underline, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(46, 202);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(168, 16);
            this.label2.TabIndex = 5;
            this.label2.Text = "Method To Save Evidence";
            // 
            // saveBox
            // 
            this.saveBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.saveBox.FormattingEnabled = true;
            this.saveBox.Items.AddRange(new object[] {
            "Local",
            "Netcat Session"});
            this.saveBox.Location = new System.Drawing.Point(49, 221);
            this.saveBox.Name = "saveBox";
            this.saveBox.Size = new System.Drawing.Size(165, 21);
            this.saveBox.TabIndex = 6;
            this.saveBox.SelectedIndexChanged += new System.EventHandler(this.saveBox_SelectedIndexChanged);
            // 
            // warningText
            // 
            this.warningText.AutoSize = true;
            this.warningText.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.warningText.Location = new System.Drawing.Point(9, 279);
            this.warningText.Name = "warningText";
            this.warningText.Size = new System.Drawing.Size(174, 13);
            this.warningText.TabIndex = 7;
            this.warningText.Text = "Warning: No Save Option Selected";
            // 
            // portText
            // 
            this.portText.AutoSize = true;
            this.portText.Location = new System.Drawing.Point(46, 245);
            this.portText.Name = "portText";
            this.portText.Size = new System.Drawing.Size(100, 13);
            this.portText.TabIndex = 8;
            this.portText.Text = "Send Through Port:";
            this.portText.Visible = false;
            // 
            // portTextBox
            // 
            this.portTextBox.Location = new System.Drawing.Point(152, 245);
            this.portTextBox.Name = "portTextBox";
            this.portTextBox.Size = new System.Drawing.Size(100, 20);
            this.portTextBox.TabIndex = 9;
            this.portTextBox.Visible = false;
            // 
            // ntlast
            // 
            this.ntlast.AutoSize = true;
            this.ntlast.Checked = true;
            this.ntlast.CheckState = System.Windows.Forms.CheckState.Checked;
            this.ntlast.Location = new System.Drawing.Point(12, 90);
            this.ntlast.Name = "ntlast";
            this.ntlast.Size = new System.Drawing.Size(61, 17);
            this.ntlast.TabIndex = 11;
            this.ntlast.Text = "NTLast";
            this.ntlast.UseVisualStyleBackColor = true;
            // 
            // userdump
            // 
            this.userdump.AutoSize = true;
            this.userdump.Checked = true;
            this.userdump.CheckState = System.Windows.Forms.CheckState.Checked;
            this.userdump.Location = new System.Drawing.Point(12, 113);
            this.userdump.Name = "userdump";
            this.userdump.Size = new System.Drawing.Size(74, 17);
            this.userdump.TabIndex = 12;
            this.userdump.Text = "Userdump";
            this.userdump.UseVisualStyleBackColor = true;
            // 
            // netstat_an
            // 
            this.netstat_an.AutoSize = true;
            this.netstat_an.Checked = true;
            this.netstat_an.CheckState = System.Windows.Forms.CheckState.Checked;
            this.netstat_an.Location = new System.Drawing.Point(12, 136);
            this.netstat_an.Name = "netstat_an";
            this.netstat_an.Size = new System.Drawing.Size(78, 17);
            this.netstat_an.TabIndex = 13;
            this.netstat_an.Text = "Netstat -an";
            this.netstat_an.UseVisualStyleBackColor = true;
            // 
            // netstat_rn
            // 
            this.netstat_rn.AutoSize = true;
            this.netstat_rn.Checked = true;
            this.netstat_rn.CheckState = System.Windows.Forms.CheckState.Checked;
            this.netstat_rn.Location = new System.Drawing.Point(12, 159);
            this.netstat_rn.Name = "netstat_rn";
            this.netstat_rn.Size = new System.Drawing.Size(75, 17);
            this.netstat_rn.TabIndex = 14;
            this.netstat_rn.Text = "Netstat -rn";
            this.netstat_rn.UseVisualStyleBackColor = true;
            // 
            // psfile
            // 
            this.psfile.AutoSize = true;
            this.psfile.Checked = true;
            this.psfile.CheckState = System.Windows.Forms.CheckState.Checked;
            this.psfile.Location = new System.Drawing.Point(12, 182);
            this.psfile.Name = "psfile";
            this.psfile.Size = new System.Drawing.Size(50, 17);
            this.psfile.TabIndex = 16;
            this.psfile.Text = "psfile";
            this.psfile.UseVisualStyleBackColor = true;
            // 
            // pslist
            // 
            this.pslist.AutoSize = true;
            this.pslist.Checked = true;
            this.pslist.CheckState = System.Windows.Forms.CheckState.Checked;
            this.pslist.Location = new System.Drawing.Point(97, 90);
            this.pslist.Name = "pslist";
            this.pslist.Size = new System.Drawing.Size(49, 17);
            this.pslist.TabIndex = 17;
            this.pslist.Text = "pslist";
            this.pslist.UseVisualStyleBackColor = true;
            // 
            // ipconfig_all
            // 
            this.ipconfig_all.AutoSize = true;
            this.ipconfig_all.Checked = true;
            this.ipconfig_all.CheckState = System.Windows.Forms.CheckState.Checked;
            this.ipconfig_all.Location = new System.Drawing.Point(97, 113);
            this.ipconfig_all.Name = "ipconfig_all";
            this.ipconfig_all.Size = new System.Drawing.Size(79, 17);
            this.ipconfig_all.TabIndex = 18;
            this.ipconfig_all.Text = "ipconfig -all";
            this.ipconfig_all.UseVisualStyleBackColor = true;
            // 
            // date
            // 
            this.date.AutoSize = true;
            this.date.Checked = true;
            this.date.CheckState = System.Windows.Forms.CheckState.Checked;
            this.date.Location = new System.Drawing.Point(97, 136);
            this.date.Name = "date";
            this.date.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.date.Size = new System.Drawing.Size(49, 17);
            this.date.TabIndex = 19;
            this.date.Text = "Date";
            this.date.UseVisualStyleBackColor = true;
            // 
            // time
            // 
            this.time.AutoSize = true;
            this.time.Checked = true;
            this.time.CheckState = System.Windows.Forms.CheckState.Checked;
            this.time.Location = new System.Drawing.Point(97, 159);
            this.time.Name = "time";
            this.time.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.time.Size = new System.Drawing.Size(49, 17);
            this.time.TabIndex = 20;
            this.time.Text = "Time";
            this.time.UseVisualStyleBackColor = true;
            // 
            // psinfo_h_s_d
            // 
            this.psinfo_h_s_d.AutoSize = true;
            this.psinfo_h_s_d.Checked = true;
            this.psinfo_h_s_d.CheckState = System.Windows.Forms.CheckState.Checked;
            this.psinfo_h_s_d.Location = new System.Drawing.Point(193, 67);
            this.psinfo_h_s_d.Name = "psinfo_h_s_d";
            this.psinfo_h_s_d.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.psinfo_h_s_d.Size = new System.Drawing.Size(89, 17);
            this.psinfo_h_s_d.TabIndex = 21;
            this.psinfo_h_s_d.Text = "psinfo -h -s -d";
            this.psinfo_h_s_d.UseVisualStyleBackColor = true;
            // 
            // psloggedon
            // 
            this.psloggedon.AutoSize = true;
            this.psloggedon.Checked = true;
            this.psloggedon.CheckState = System.Windows.Forms.CheckState.Checked;
            this.psloggedon.Location = new System.Drawing.Point(193, 90);
            this.psloggedon.Name = "psloggedon";
            this.psloggedon.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.psloggedon.Size = new System.Drawing.Size(81, 17);
            this.psloggedon.TabIndex = 22;
            this.psloggedon.Text = "psloggedon";
            this.psloggedon.UseVisualStyleBackColor = true;
            // 
            // psservice
            // 
            this.psservice.AutoSize = true;
            this.psservice.Checked = true;
            this.psservice.CheckState = System.Windows.Forms.CheckState.Checked;
            this.psservice.Location = new System.Drawing.Point(97, 67);
            this.psservice.Name = "psservice";
            this.psservice.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.psservice.Size = new System.Drawing.Size(71, 17);
            this.psservice.TabIndex = 23;
            this.psservice.Text = "psservice";
            this.psservice.UseVisualStyleBackColor = true;
            // 
            // schtasks
            // 
            this.schtasks.AutoSize = true;
            this.schtasks.Checked = true;
            this.schtasks.CheckState = System.Windows.Forms.CheckState.Checked;
            this.schtasks.Location = new System.Drawing.Point(193, 113);
            this.schtasks.Name = "schtasks";
            this.schtasks.Size = new System.Drawing.Size(68, 17);
            this.schtasks.TabIndex = 24;
            this.schtasks.Text = "schtasks";
            this.schtasks.UseVisualStyleBackColor = true;
            // 
            // find
            // 
            this.find.AutoSize = true;
            this.find.Location = new System.Drawing.Point(193, 136);
            this.find.Name = "find";
            this.find.Size = new System.Drawing.Size(87, 17);
            this.find.TabIndex = 25;
            this.find.Text = "find (All Files)";
            this.find.UseVisualStyleBackColor = true;
            // 
            // psloglist
            // 
            this.psloglist.AutoSize = true;
            this.psloglist.Checked = true;
            this.psloglist.CheckState = System.Windows.Forms.CheckState.Checked;
            this.psloglist.Location = new System.Drawing.Point(193, 159);
            this.psloglist.Name = "psloglist";
            this.psloglist.Size = new System.Drawing.Size(124, 17);
            this.psloglist.TabIndex = 26;
            this.psloglist.Text = "psloglist -s -x security";
            this.psloglist.UseVisualStyleBackColor = true;
            // 
            // sha1sum
            // 
            this.sha1sum.AutoSize = true;
            this.sha1sum.Checked = true;
            this.sha1sum.CheckState = System.Windows.Forms.CheckState.Checked;
            this.sha1sum.Location = new System.Drawing.Point(324, 275);
            this.sha1sum.Name = "sha1sum";
            this.sha1sum.Size = new System.Drawing.Size(124, 17);
            this.sha1sum.TabIndex = 27;
            this.sha1sum.Text = "Sha1 all created files";
            this.sha1sum.UseVisualStyleBackColor = true;
            // 
            // toolsButton
            // 
            this.toolsButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.toolsButton.Location = new System.Drawing.Point(209, 298);
            this.toolsButton.Name = "toolsButton";
            this.toolsButton.Size = new System.Drawing.Size(155, 40);
            this.toolsButton.TabIndex = 28;
            this.toolsButton.Text = "Get Tools";
            this.toolsButton.UseVisualStyleBackColor = true;
            this.toolsButton.Click += new System.EventHandler(this.toolsButton_Click);
            // 
            // button1
            // 
            this.button1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button1.Location = new System.Drawing.Point(12, 298);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(150, 40);
            this.button1.TabIndex = 29;
            this.button1.Text = "Start Listener";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click_1);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(550, 350);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.toolsButton);
            this.Controls.Add(this.sha1sum);
            this.Controls.Add(this.psloglist);
            this.Controls.Add(this.find);
            this.Controls.Add(this.schtasks);
            this.Controls.Add(this.psservice);
            this.Controls.Add(this.psloggedon);
            this.Controls.Add(this.psinfo_h_s_d);
            this.Controls.Add(this.time);
            this.Controls.Add(this.date);
            this.Controls.Add(this.ipconfig_all);
            this.Controls.Add(this.pslist);
            this.Controls.Add(this.psfile);
            this.Controls.Add(this.netstat_rn);
            this.Controls.Add(this.netstat_an);
            this.Controls.Add(this.userdump);
            this.Controls.Add(this.ntlast);
            this.Controls.Add(this.portTextBox);
            this.Controls.Add(this.portText);
            this.Controls.Add(this.warningText);
            this.Controls.Add(this.saveBox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.fport);
            this.Controls.Add(this.output);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.captureButton);
            this.Controls.Add(this.titleText);
            this.Name = "Form1";
            this.Text = " ";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label titleText;
        private System.Windows.Forms.Button captureButton;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.RichTextBox output;
        private System.Windows.Forms.CheckBox fport;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox saveBox;
        private System.Windows.Forms.Label warningText;
        private System.Windows.Forms.Label portText;
        private System.Windows.Forms.TextBox portTextBox;
        private System.Windows.Forms.CheckBox ntlast;
        private System.Windows.Forms.CheckBox userdump;
        private System.Windows.Forms.CheckBox netstat_an;
        private System.Windows.Forms.CheckBox netstat_rn;
        private System.Windows.Forms.CheckBox psfile;
        private System.Windows.Forms.CheckBox pslist;
        private System.Windows.Forms.CheckBox ipconfig_all;
        private System.Windows.Forms.CheckBox date;
        private System.Windows.Forms.CheckBox time;
        private System.Windows.Forms.CheckBox psinfo_h_s_d;
        private System.Windows.Forms.CheckBox psloggedon;
        private System.Windows.Forms.CheckBox psservice;
        private System.Windows.Forms.CheckBox schtasks;
        private System.Windows.Forms.CheckBox find;
        private System.Windows.Forms.CheckBox psloglist;
        private System.Windows.Forms.CheckBox sha1sum;
        private System.Windows.Forms.Button toolsButton;
        private System.Windows.Forms.Button button1;
    }
}

