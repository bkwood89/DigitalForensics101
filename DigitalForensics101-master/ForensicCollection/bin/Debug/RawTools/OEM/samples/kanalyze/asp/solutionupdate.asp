<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    solutionupdate.asp

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
    Set SolutionID=Request.QueryString("SolutionID")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>Solution Update</h1>
<%
    Command="select SolutionID,Abstract,SolutionDescription,Keywords,LastUpdated"
    Command=Command+" from Solution where SolutionID="+SolutionID
    Set Data=Connecter.Execute(Command)

    If not SolutionID=1 Then
%>
    <form action="solutionupdateex.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&SolutionID=<% =SolutionID %>" method="post">
    <table width="100%">
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>SolutionID</td>
            <td><% =SolutionID %></td>
        </tr>
        <tr>
            <td>Abstract<br>(350chr)</td>
            <td><textarea name="Abstract" rows="5" cols="50"><% =Data("Abstract") %></textarea></td>
        </tr>
        <tr>
            <td>SolutionDescription<br>(3250chr)</td>
            <td><textarea name="SolutionDescription" rows="10" cols="50"><% =Data("SolutionDescription") %></textarea></td>
        </tr>
        <tr>
            <td>Keywords<br>(400chr)</td>
            <td><textarea name="Keywords" rows="5" cols="50"><% =Data("Keywords") %></textarea></td>
        </tr>
        <tr>
            <td>LastUpdated</td>
            <td><% =Data("LastUpdated") %></td>
        </tr>
    </table>
    <p>
    <input type="submit" value="Update">
<%
    else
%>
    Warning: You Can not update SolutionID 1
<%
    End If
    Data.Close
    Connecter.Close
%>
</body>
</html>
