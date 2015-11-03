<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    progressinsertex.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 19-NOV-1999

Revision History:

-->
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set ClassID=Request.QueryString("ClassID")
    Set AnalysisID=Request.QueryString("AnalysisID")
    Connecter.Open(DSN)

    Command="insert into ProgressText (AnalysisID,DateTime,Annotation,Author) values("
    Command=Command+Request.Form("AnalysisID")+","
    Command=Command+"'"+Request.Form("DateTime")+"',"
    Command=Command+"'"+Left(Replace( Request.Form("Annotation"), "'", "''"),3800)+"',"
    Command=Command+"'"+Left(Replace( Request.Form("Author"), "'", "''"),75)+"')"
    Set Data=Connecter.Execute(Command)

    Response.Redirect "crashclass.asp?DSN="&DSN&"&ClassID="&ClassID
%>
