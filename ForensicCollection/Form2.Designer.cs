namespace ForensicCollection
{
    partial class Form2
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
            this.Title = new System.Windows.Forms.Label();
            this.start = new System.Windows.Forms.Button();
            this.Cancel = new System.Windows.Forms.Button();
            this.warningText = new System.Windows.Forms.Label();
            this.toolsListText = new System.Windows.Forms.Label();
            this.fport = new System.Windows.Forms.Label();
            this.ntlast = new System.Windows.Forms.Label();
            this.sysinternals = new System.Windows.Forms.Label();
            this.oem = new System.Windows.Forms.Label();
            this.unixutils = new System.Windows.Forms.Label();
            this.phase1 = new System.Windows.Forms.Label();
            this.phase2 = new System.Windows.Forms.Label();
            this.phase3 = new System.Windows.Forms.Label();
            this.phasecomplete = new System.Windows.Forms.Label();
            this.keepFiles = new System.Windows.Forms.CheckBox();
            this.filename = new System.Windows.Forms.Label();
            this.finishText = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // Title
            // 
            this.Title.AutoSize = true;
            this.Title.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Title.Location = new System.Drawing.Point(134, 9);
            this.Title.Name = "Title";
            this.Title.Size = new System.Drawing.Size(236, 20);
            this.Title.TabIndex = 0;
            this.Title.Text = "Setup Forensic Enviornment";
            // 
            // start
            // 
            this.start.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.start.Location = new System.Drawing.Point(385, 209);
            this.start.Name = "start";
            this.start.Size = new System.Drawing.Size(124, 38);
            this.start.TabIndex = 1;
            this.start.Text = "Start";
            this.start.UseVisualStyleBackColor = true;
            this.start.Click += new System.EventHandler(this.start_Click);
            // 
            // Cancel
            // 
            this.Cancel.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Cancel.Location = new System.Drawing.Point(12, 209);
            this.Cancel.Name = "Cancel";
            this.Cancel.Size = new System.Drawing.Size(119, 37);
            this.Cancel.TabIndex = 2;
            this.Cancel.Text = "Cancel";
            this.Cancel.UseVisualStyleBackColor = true;
            this.Cancel.Click += new System.EventHandler(this.Cancel_Click);
            // 
            // warningText
            // 
            this.warningText.AllowDrop = true;
            this.warningText.AutoSize = true;
            this.warningText.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.warningText.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.warningText.Location = new System.Drawing.Point(10, 29);
            this.warningText.Name = "warningText";
            this.warningText.Size = new System.Drawing.Size(499, 13);
            this.warningText.TabIndex = 3;
            this.warningText.Text = "Warning: This will download files. Please make sure you are on your forensic mach" +
    "ine prior to continuing.";
            // 
            // toolsListText
            // 
            this.toolsListText.AutoSize = true;
            this.toolsListText.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Underline, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.toolsListText.Location = new System.Drawing.Point(10, 51);
            this.toolsListText.Name = "toolsListText";
            this.toolsListText.Size = new System.Drawing.Size(183, 13);
            this.toolsListText.TabIndex = 4;
            this.toolsListText.Text = "This will download the following tools:";
            // 
            // fport
            // 
            this.fport.AutoSize = true;
            this.fport.Location = new System.Drawing.Point(10, 64);
            this.fport.Name = "fport";
            this.fport.Size = new System.Drawing.Size(31, 13);
            this.fport.TabIndex = 5;
            this.fport.Text = "Fport";
            // 
            // ntlast
            // 
            this.ntlast.AutoSize = true;
            this.ntlast.Location = new System.Drawing.Point(10, 77);
            this.ntlast.Name = "ntlast";
            this.ntlast.Size = new System.Drawing.Size(42, 13);
            this.ntlast.TabIndex = 6;
            this.ntlast.Text = "NTLast";
            // 
            // sysinternals
            // 
            this.sysinternals.AutoSize = true;
            this.sysinternals.Location = new System.Drawing.Point(10, 90);
            this.sysinternals.Name = "sysinternals";
            this.sysinternals.Size = new System.Drawing.Size(137, 13);
            this.sysinternals.TabIndex = 7;
            this.sysinternals.Text = "Microsoft\'s System Internals";
            // 
            // oem
            // 
            this.oem.AutoSize = true;
            this.oem.Location = new System.Drawing.Point(10, 103);
            this.oem.Name = "oem";
            this.oem.Size = new System.Drawing.Size(153, 13);
            this.oem.TabIndex = 8;
            this.oem.Text = "Microsoft\'s OEM Support Tools";
            // 
            // unixutils
            // 
            this.unixutils.AutoSize = true;
            this.unixutils.Location = new System.Drawing.Point(10, 116);
            this.unixutils.Name = "unixutils";
            this.unixutils.Size = new System.Drawing.Size(64, 13);
            this.unixutils.TabIndex = 9;
            this.unixutils.Text = "Unix Utilities";
            // 
            // phase1
            // 
            this.phase1.AutoSize = true;
            this.phase1.Location = new System.Drawing.Point(268, 64);
            this.phase1.Name = "phase1";
            this.phase1.Size = new System.Drawing.Size(171, 13);
            this.phase1.TabIndex = 16;
            this.phase1.Text = "Phase 1 of 3, Downloading Files ...";
            this.phase1.Visible = false;
            // 
            // phase2
            // 
            this.phase2.AutoSize = true;
            this.phase2.Location = new System.Drawing.Point(268, 90);
            this.phase2.Name = "phase2";
            this.phase2.Size = new System.Drawing.Size(153, 13);
            this.phase2.TabIndex = 17;
            this.phase2.Text = "Phase 2 of 3 Extracting Files ...";
            this.phase2.Visible = false;
            // 
            // phase3
            // 
            this.phase3.AutoSize = true;
            this.phase3.Location = new System.Drawing.Point(268, 116);
            this.phase3.Name = "phase3";
            this.phase3.Size = new System.Drawing.Size(246, 13);
            this.phase3.TabIndex = 18;
            this.phase3.Text = "Phase 3 of 3 Setuping Up Forensic Enviornment ...";
            this.phase3.Visible = false;
            // 
            // phasecomplete
            // 
            this.phasecomplete.AutoSize = true;
            this.phasecomplete.ForeColor = System.Drawing.Color.Blue;
            this.phasecomplete.Location = new System.Drawing.Point(268, 144);
            this.phasecomplete.Name = "phasecomplete";
            this.phasecomplete.Size = new System.Drawing.Size(54, 13);
            this.phasecomplete.TabIndex = 19;
            this.phasecomplete.Text = "Complete!";
            this.phasecomplete.Visible = false;
            // 
            // keepFiles
            // 
            this.keepFiles.AutoSize = true;
            this.keepFiles.Location = new System.Drawing.Point(383, 186);
            this.keepFiles.Name = "keepFiles";
            this.keepFiles.Size = new System.Drawing.Size(136, 17);
            this.keepFiles.TabIndex = 20;
            this.keepFiles.Text = "Keep downloaded Files";
            this.keepFiles.UseVisualStyleBackColor = true;
            // 
            // filename
            // 
            this.filename.AutoSize = true;
            this.filename.ForeColor = System.Drawing.Color.Blue;
            this.filename.Location = new System.Drawing.Point(13, 186);
            this.filename.Name = "filename";
            this.filename.Size = new System.Drawing.Size(137, 13);
            this.filename.TabIndex = 21;
            this.filename.Text = "Beginning Forensic Setup...";
            this.filename.Visible = false;
            // 
            // finishText
            // 
            this.finishText.AutoSize = true;
            this.finishText.Location = new System.Drawing.Point(13, 170);
            this.finishText.Name = "finishText";
            this.finishText.Size = new System.Drawing.Size(230, 13);
            this.finishText.TabIndex = 22;
            this.finishText.Text = "Find the extract tools in the \"RawTools\" Folder.";
            this.finishText.Visible = false;
            // 
            // Form2
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(531, 257);
            this.Controls.Add(this.finishText);
            this.Controls.Add(this.filename);
            this.Controls.Add(this.keepFiles);
            this.Controls.Add(this.phasecomplete);
            this.Controls.Add(this.phase3);
            this.Controls.Add(this.phase2);
            this.Controls.Add(this.phase1);
            this.Controls.Add(this.unixutils);
            this.Controls.Add(this.oem);
            this.Controls.Add(this.sysinternals);
            this.Controls.Add(this.ntlast);
            this.Controls.Add(this.fport);
            this.Controls.Add(this.toolsListText);
            this.Controls.Add(this.warningText);
            this.Controls.Add(this.Cancel);
            this.Controls.Add(this.start);
            this.Controls.Add(this.Title);
            this.Name = "Form2";
            this.Text = "Form2";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label Title;
        private System.Windows.Forms.Button start;
        private System.Windows.Forms.Button Cancel;
        private System.Windows.Forms.Label warningText;
        private System.Windows.Forms.Label toolsListText;
        private System.Windows.Forms.Label fport;
        private System.Windows.Forms.Label ntlast;
        private System.Windows.Forms.Label sysinternals;
        private System.Windows.Forms.Label oem;
        private System.Windows.Forms.Label unixutils;
        private System.Windows.Forms.Label phase1;
        private System.Windows.Forms.Label phase2;
        private System.Windows.Forms.Label phase3;
        private System.Windows.Forms.Label phasecomplete;
        private System.Windows.Forms.CheckBox keepFiles;
        private System.Windows.Forms.Label filename;
        private System.Windows.Forms.Label finishText;
    }
}