<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    analysis.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 18-NOV-1999

Revision History:

-->

<html>
<head>
<title>Kernel Memory Space Analyzer</title>
</head>
<body bgcolor=white>
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set AnalysisID=Request.QueryString("AnalysisID")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>Analysis</h1>
<%
    Command="select AnalysisID,Abstract,ProblemDescription,Keywords,Status"
    Command=Command+" from Analysis where AnalysisID="+AnalysisID
    Set Data=Connecter.Execute(Command)
%>
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>AnalysisID</td>
            <td><% =Data("AnalysisID") %></td>
        </tr>
        <tr>
            <td>Abstract</td>
            <td><% =Data("Abstract") %></td>
        </tr>
        <tr>
            <td>AnalysisDetails</td>
            <td><% =Data("ProblemDescription") %></td>
        </tr>
        <tr>
            <td>Keywords</td>
            <td><% =Data("Keywords") %></td>
        </tr>
        <tr>
            <td>Status</td>
            <td><% =Data("Status") %></td>
        </tr>
    </table>
    <p>
    <a href="analysisupdate.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&AnalysisID=<% =AnalysisID %>">Analysis Update</a>
<%
    Data.Close
    Connecter.Close
%>
</body>
</html>
