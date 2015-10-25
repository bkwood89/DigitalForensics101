<% @Language = "VBScript" %>
<% Response.buffer = true %>
<!--
Copyright (c) 1998-1999 Microsoft Corporation

Module Name:

    solutioninsertex.asp

Abstract:

    

Author:

    Akifumi Nagai(v-akinag) 18-NOV-1999

Revision History:

-->
<%
    Set Connecter=Server.CreateObject("ADODB.Connection")
    Set DSN=Request.QueryString("DSN")
    Set ClassID=Request.QueryString("ClassID")
    Connecter.Open(DSN)

    '
    ' change a spesific character ( ' -> '' )
    '
    'RightString=Left(Request.Form("Abstract"),350)
    'chk=InStr(RightString,"'")
    'Abstract=""
    'Do While chk<>0
    '    LeftString=Left(RightString,chk)
    '    Abstract=Abstract & LeftString & "'"
    '    RightString=Mid(RightString,chk+1,350)
    '    chk=InStr(RightString,"'")
    'Loop

    Command="insert into Solution (Abstract,SolutionDescription,Keywords,LastUpdated) values("
    Command=Command+"'"+Left(Replace( Request.Form("Abstract"), "'", "''"),350)+"',"
    Command=Command+"'"+Left(Replace( Request.Form("SolutionDescription"), "'", "''"),3250)+"',"
    Command=Command+"'"+Left(Replace( Request.Form("Keywords"), "'", "''"),400)+"',GetDate())"
    Set Data=Connecter.Execute(Command)

    Command="select SolutionID from Solution where SolutionID in "
    Command=Command+"(select max(SolutionID) from Solution)"
    Set Data=Connecter.Execute(Command)

    SolutionID=Data("SolutionID")

    Command="update CrashClass set SolutionID="&SolutionID
    Command=Command&" where ClassID="&ClassID
    Set Data=Connecter.Execute(Command)

    Response.Redirect "crashclass.asp?DSN="&DSN&"&ClassID="&ClassID
%>
