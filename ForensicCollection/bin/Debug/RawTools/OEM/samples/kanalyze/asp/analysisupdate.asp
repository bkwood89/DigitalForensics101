<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    analysisupdate.asp

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
    <h1>Analysis Update</h1>
<%
    Command="select AnalysisID,Abstract,ProblemDescription,Keywords,Status"
    Command=Command+" from Analysis where AnalysisID="+AnalysisID
    Set Data=Connecter.Execute(Command)

    If not AnalysisID=1 Then
%>
    <form action="analysisupdateex.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&AnalysisID=<% =AnalysisID %>" method="post">
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>AnalysisID</td>
            <td><% =AnalysisID %></td>
        </tr>
        <tr>
            <td>Abstract<br>(350chr)</td>
            <td><textarea name="Abstract" rows="5" cols="50"><% =Data("Abstract") %></textarea></td>
        </tr>
        <tr>
            <td>AnalysisDetails<br>(3250chr)</td>
            <td><textarea name="AnalysisDetails" rows="10" cols="50"><% =Data("ProblemDescription") %></textarea></td>
        </tr>
        <tr>
            <td>Keywords<br>(400chr)</td>
            <td><textarea name="Keywords" rows="5" cols="50"><% =Data("Keywords") %></textarea></td>
        </tr>
        <tr>
            <td>Status(8chr)</td>
            <td><input type="text" name="Status" value="<% =Data("Status") %>"></td>
        </tr>
    </table>
    <p>
    <input type="submit" value="Update">
<%
    else
%>
    Warning: You Can not update AnalysisID 1
<%
    End If
    Data.Close
    Connecter.Close
%>
</body>
</html>
