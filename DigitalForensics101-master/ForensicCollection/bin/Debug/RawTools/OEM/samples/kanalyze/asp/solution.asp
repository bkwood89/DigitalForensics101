<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    solution.asp

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
    <h1>Solution</h1>
<%
    Command="select SolutionID,Abstract,SolutionDescription,Keywords,LastUpdated"
    Command=Command+" from Solution where SolutionID="+SolutionID
    Set Data=Connecter.Execute(Command)
%>
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>SolutionID</td>
            <td><% =SolutionID %></td>
        </tr>
        <tr>
            <td>Abstract</td>
            <td><% =Data("Abstract") %></td>
        </tr>
        <tr>
            <td>SolutionDescription</td>
            <td><% =Data("SolutionDescription") %></td>
        </tr>
        <tr>
            <td>Keywords</td>
            <td><% =Data("Keywords") %></td>
        </tr>
        <tr>
            <td>LastUpdated</td>
            <td><% =Data("LastUpdated") %></td>
        </tr>
    </table>
    <p>
    <a href="solutionupdate.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&SolutionID=<% =SolutionID %>">Solution Update</a>
<%
    Data.Close
    Connecter.Close
%>
</body>
</html>
