<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    analysisinsert.asp

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
    Set DSN=Request.QueryString("DSN")
    Set AnalysisID=Request.QueryString("AnalysisID")
    Set ClassID=Request.QueryString("ClassID")
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>Analysis Add</h1>
    <form action="analysisinsertex.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>" method="post">
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>AnalysisID</td>
            <td>-</td>
        </tr>
        <tr>
            <td>Abstract<br>(350chr)</td>
            <td><textarea name="Abstract" rows="5" cols="50"></textarea></td>
        </tr>
        <tr>
            <td>AnalysisDetails<br>(3250chr)</td>
            <td><textarea name="AnalysisDetails" rows="10" cols="50"></textarea></td>
        </tr>
        <tr>
            <td>Keywords<br>(400chr)</td>
            <td><textarea name="Keywords" rows="5" cols="50"></textarea></td>
        </tr>
        <tr>
            <td>Status(8chr)</td>
            <td><input type="text" name="Status"></td>
        </tr>
    </table>
    <p>
    <input type="submit" value="New">
</body>
</html>
