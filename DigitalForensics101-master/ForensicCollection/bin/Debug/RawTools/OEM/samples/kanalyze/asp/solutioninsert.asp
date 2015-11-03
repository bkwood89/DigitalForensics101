<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    solutioninsert.asp

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
    Set SolutionID=Request.QueryString("SolutionID")
    Set ClassID=Request.QueryString("ClassID")
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>Solution Add</h1>
    <form action="solutioninsertex.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>" method="post">

    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>SolutionID</td>
            <td>-</td>
        </tr>
        <tr>
            <td>Abstract<br>(350chr)</td>
            <td><textarea name="Abstract" rows="5" cols="50">[not null]</textarea></td>
        </tr>
        <tr>
            <td>SolutionDescription<br>(3250chr)</td>
            <td><textarea name="SolutionDescription" rows="10" cols="50">[not null]</textarea></td>
        </tr>
        <tr>
            <td>Keywords<br>(400chr)</td>
            <td><textarea name="Keywords" rows="5" cols="50"></textarea></td>
        </tr>
        <tr>
            <td>LastUpdated</td>
            <td>-</td>
        </tr>
    </table>
    <p>
    <input type="submit" value="New">
</body>
</html>
