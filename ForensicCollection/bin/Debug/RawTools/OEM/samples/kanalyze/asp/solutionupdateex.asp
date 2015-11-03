<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    solutionupdateex.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 18-NOV-1999

Revision History:

-->
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set SolutionID=Request.QueryString("SolutionID")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)

    Command="update Solution set "
    Command=Command+"Abstract='"+Left(Replace( Request.Form("Abstract"), "'", "''"),350)+"',"
    Command=Command+"SolutionDescription='"+Left(Replace( Request.Form("SolutionDescription"), "'", "''"),3250)+"',"
    Command=Command+"Keywords='"+Left(Replace( Request.Form("Keywords"), "'", "''"),400)+"',"
    Command=Command+"LastUpdated=GetDate() where SolutionID="+SolutionID
    Set Data=Connecter.Execute(Command)

    Response.Redirect "solution.asp?DSN="+DSN+"&ClassID="+ClassID+"&SolutionID="+SolutionID
%>
