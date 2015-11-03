<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    hintdatainsert.asp

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
    Set ClassID=Request.QueryString("ClassID")
    Set SolutionID=Request.QueryString("SolutionID")

    Connecter.Open(DSN)

    Command="select SolutionID from Solution where SolutionID="&SolutionID
    Set Data=Connecter.Execute(Command)

    Command="select SolutionID,Abstract from Solution"
    Set SolutionData=Connecter.Execute(Command)
%>
    <a href="crashclass.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>">Return to CrashClass Table</a>
    <h1>HintData Add</h1>
    <form action="hintdatainsertex.asp?DSN=<% =DSN %>&ClassID=<% =ClassID %>&SolutionID=<% =SolutionID %>" method="post">
    <table>
        <tr>
            <th>Column Name</th>
            <th>Value</th>
        </tr>
        <tr>
            <td>DataID</td>
            <td>-</td>
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
            <td><textarea name="Data" rows="10" cols="50">[not null]</textarea></td>
        </tr>
    </table>
    <p>
    <input type="submit" value="New">
</body>
</html>
