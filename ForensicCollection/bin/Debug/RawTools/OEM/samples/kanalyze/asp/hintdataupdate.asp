<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    hintdataupdate.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 19-NOV-1999

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
    Set DataID=Request.QueryString("DataID")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>HintData Update</h1>
<%
    Command="select SolutionID,Data from HintData where DataID="+DataID
    Set Data=Connecter.Execute(Command)

    Command="select SolutionID,Abstract from Solution"
    Set SolutionData=Connecter.Execute(Command)
%>
    <form action="hintdataupdateex.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&DataID=<% =DataID %>" method="post">
    <input type="hidden" name="DataID" value="<% =DataID %>">
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>DataID</td>
            <td><% =DataID %></td>
        </tr>
        <tr>
            <td>SolutionID</td>
            <td><select name="SolutionID">
                <% Do While not SolutionData.EOF %>
                    <option <% If SolutionData("SolutionID")=Data("SolutionID") Then %>
                                selected
                            <% End If %>
                            value="<% =SolutionData("SolutionID") %>"><% =SolutionData("SolutionID") %> : <% =Left(SolutionData("Abstract"),80) %>
                <% SolutionData.MoveNext
                Loop %>
                </select>
            </td>
        </tr>
        <tr>
            <td>Data<br>(2500chr)</td>
            <td><textarea name="Data" rows="5" cols="50"><% =Data("Data") %></textarea></td>
        </tr>
    </table>
    <p>
    <input type="submit" value="Update">
<%
    SolutionData.Close
    Data.Close
    Connecter.Close
%>
</body>
</html>
